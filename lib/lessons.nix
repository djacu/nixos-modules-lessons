{
  self,
  pkgs,
  lib,
  ...
}: rec {
  getLessons = {lessonsPath ? ../lessons, ...}: (
    lib.mapAttrs
    (name: _: lib.path.append lessonsPath name)
    (
      lib.filterAttrs
      (name: type: type == "directory")
      (builtins.readDir lessonsPath)
    )
  );

  /*
  Return the extension of a file.

  # Example

  ```nix
  getFileExtension ./directory/eval.nix
  => "nix"
  getFileExtension ./directory/run
  => ""
  getFileExtension ./directory/archive.tar.xz
  => "tar.xz"
  getFileExtension "./directory/eval.nix"
  => "nix"
  getFileExtension "./directory/run"
  => ""
  getFileExtension "./directory/archive.tar.xz"
  => "tar.xz"
  ```

  # Type

  ```
  getFileExtension :: Path -> String
  getFileExtension :: String -> String
  ```

  # Arguments

  - [path] A path or string that contains a path to a file.
  */
  getFileExtension = path: (
    lib.concatStringsSep
    "."
    (
      builtins.tail (
        lib.splitString
        "."
        (
          builtins.baseNameOf
          path
        )
      )
    )
  );

  /*
  Like `match` but works on multiline strings.

  Returns a list if the extended POSIX regular expression regex matches str precisely, otherwise returns null.
  Each item in the list is a regex group.

  # Example

  ```nix
  multilineMatch
  ''(\[//]: # \(.*\..*\))''
  ''
    In the `options.nix` file, we have declared boolean, enumeration, integer, and string options.

    [//]: # (./options.nix)

    In the `config.nix` file, we have declared values for all these options.

    [//]: # (./config.nix)

    In the `eval.nix` file, we evaluate our options and config and have it return the config values.
  ''
  => [ "[//]: # (./options.nix)" "[//]: # (./config.nix)" ]
  ```

  # Type

  ```
  multilineMatch :: String -> String -> [String]
  ```

  # Arguments

  - [regex] The regular expression.
  - [input] The string to search.
  */
  multilineMatch = regex: input: (
    lib.flatten
    (
      builtins.filter
      (elem: ! builtins.isNull elem)
      (
        builtins.map
        (
          lib.strings.match
          regex
        )
        (
          lib.splitString
          "\n"
          input
        )
      )
    )
  );

  /*
  Create a fenced code block with language identifier and file name given a file.

  # Example

  ````nix
  makeFencedCodeBlock ./eval.nix
  => ''
  ``` nix title="eval.nix"
  let
    a = 1;
  in
    a
  ```
  ''
  ````

  # Type

  ```
  makeFencedCodeBlock :: Path -> String
  ```

  # Arguments

  - [path] The file.
  */
  makeFencedCodeBlock = file: ''
    ``` ${getFileExtension file} title="${builtins.baseNameOf file}"
    ${builtins.readFile file}
    ```
  '';

  /*
  Given a lesson, create the metadata necessary to create the markdown documentation.
  */
  createLessonMetadata = {lessonFile ? "lesson.md", ...}: name: value: let
    lessonDir = name;
    lessonPath = value;
    rawLesson = builtins.readFile (lib.path.append lessonPath lessonFile);

    commentLineMatch = ''(\[//]: # \(.*\..*\))'';
    commentFileMatch = ''\[//]: # \(\./(.*)\)'';
    linesToReplace = multilineMatch commentLineMatch rawLesson;
    filesToSubstitute = (
      builtins.map
      (
        lib.path.append
        lessonPath
      )
      (
        lib.flatten
        (
          builtins.map
          (
            multilineMatch
            commentFileMatch
          )
          linesToReplace
        )
      )
    );
    textToSubstitute = (
      builtins.map
      makeFencedCodeBlock
      filesToSubstitute
    );
  in rec {
    outputParentDir = "lessons/" + lessonDir;
    outputFilePath = outputParentDir + "/" + lessonFile;
    subsLesson = (
      builtins.replaceStrings
      [''[//]: # (evaluatedLesson)'']
      [
        ''
          ```nix
          ${(lib.generators.toPretty {} evaluatedLesson)}
          ```
        ''
      ]
      (
        builtins.replaceStrings
        linesToReplace
        textToSubstitute
        rawLesson
      )
    );
    evaluatedLesson =
      (
        lib.evalModules {
          modules = [
            (lib.path.append lessonPath "options.nix")
            (lib.path.append lessonPath "config.nix")
          ];
        }
      )
      .config;
  };

  /*
  Maps over all the lessons and generates metadata.
  */
  lessonsToMetadata = args: (
    lib.mapAttrs
    (createLessonMetadata args)
    (getLessons args)
  );

  /*
  Given a list of lesson metadata attrsets, copy the contents to the nix store.
  */
  copyLessonsToNixStore = lessons:
    pkgs.runCommand
    "copy-module-lessons"
    {}
    ''
      mkdir $out
      ${
        (
          lib.concatStringsSep
          "\n"
          (
            builtins.map
            (
              lesson: ''
                mkdir -p $out/${lesson.outputParentDir}
                touch $out/${lesson.outputFilePath}
                echo ${lib.escapeShellArg lesson.subsLesson} > $out/${lesson.outputFilePath}
              ''
            )
            lessons
          )
        )
      }
    '';

  /*
  Primary function for building lesson documentation.

  Is used when building the site.
  */
  generateLessonsDocumentation = args: (
    copyLessonsToNixStore
    (
      builtins.attrValues
      (lessonsToMetadata args)
    )
  );

  /*
  Builds the lessons documentation and copies it to the needed location in the mkdocs directory.

  Primary use is for developing with `mkdocs serve`.
  */
  copyLessonsToSite =
    pkgs.writeShellScriptBin
    "copy-lessons-to-site"
    ''
      #!/usr/bin/env bash
      nix build .\#lessonsDocumentation
      rm -rf site/docs/lessons
      cp -r ./result/* ./site/docs/
      chmod +w -R ./site/docs/lessons
    '';
}
