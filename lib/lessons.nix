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

  createLessonMetadata = name: value: let
    lessonPath = value;
    rawLesson = builtins.readFile (lib.path.append lessonPath "lesson.md");
  in rec {
    outputParentDir = "lessons/" + name;
    outputFilePath = outputParentDir + "/lesson.md";
    linesToReplace = findStrings ''(\[//]: # \(.*\..*\))'' rawLesson;
    filesToSubstitute = (
      lib.flatten
      (
        builtins.map
        (
          findStrings
          ''\[//]: # \(\./(.*)\)''
        )
        linesToReplace
      )
    );
    textToSubstitute = (
      builtins.map
      (
        file: let
          fileExtension = getFileExtension file;
        in ''
          ``` ${fileExtension} title="${file}"
          ${
            builtins.readFile
            (
              lib.path.append lessonPath file
            )
          }
          ```
        ''
      )
      filesToSubstitute
    );
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

  lessonsToMetadata = {lessonsPath ? ../lessons, ...}: (
    lib.mapAttrs
    createLessonMetadata
    (getLessons {inherit lessonsPath;})
  );

  findStrings = regex: input: (
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
  generateLessonsDocumentation = args: (
    copyLessonsToNixStore
    (
      builtins.attrValues
      (lessonsToMetadata args)
    )
  );

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
