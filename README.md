# qlevar_local_manager

This app will help you manage you applications locals easily. set you locals in groups, translate them with google translation and then export them to a class that is useable with Getx.

- [qlevar_local_manager](#qlevar_local_manager)
  - [Quick Demo](#quick-demo)
  - [Getting Started](#getting-started)
  - [Data Schema](#data-schema)
  - [Translation](#translation)
  - [Export](#export)
    - [GetX](#getx)
    - [Easy Localization](#easy-localization)


## Quick Demo

https://user-images.githubusercontent.com/49782771/124331112-1095ef80-db8f-11eb-8641-92eb7e58fb29.mp4

## Getting Started

- launch the application
- add you first app
  - The name of you app
  - The path where to save the locals in form to reuse them later (this should be in you repo files, so any update on you locals will be saved with the project)
  - The path where to export the generated files.
- Open you app.
- Add go.

## Data Schema

The data schema in the application is like json schema. Item and Node.
Every item has key and value. the value here is the translations in all defined languages.
Every Node can have many items and many node.

## Translation

you can translate the local using google translation. you need to set the google apiKey and click translate in the options button.
Only Local items can be translated. and this will translate only the empty locals for the selected item.

## Export

After adding all the data and translate them. you can export it and use it with [GetX](https://pub.dev/packages/get) or [EasyLocalization](https://pub.dev/packages/easy_localization)
In the AppBar click on Export and Export sheet will appear

### GetX

To export the data to file that matches [translations schema](https://github.com/jonataslaw/getx#translations)

- Chose Getx
- Pick the folder to export the class to.
- A file with name `locals.g.dart` will be generated in the folder and ready to use.

### Easy Localization

To export the data to json files with this [structure](https://github.com/aissat/easy_localization#-installation)

- Chose easyLocalization
- Pick the folder to export the files to.
- Json files will be generated every file has the name of language and contains the translations for this language.



