## Contents

- [Contents](#contents)
- [Getting started](#getting-started)
- [General](#general)
  - [Code structure](#code-structure)
- [Working with user settings](#working-with-user-settings)
- [Database](#database)
  - [Database structure](#database-structure)
- [Working with Isar](#working-with-isar)

## Getting started



## General

### Code structure

Todo provide quick describtion of each catalog, or throw out this section
```
    ├─ android/
    ├─ assets/
    ├─ build/
    ├─ docs/
    |- ios/
    ├─ lib/
    |   |- features/    asdasdasdasdasdassassasassasasaasdasdada
    |   |- shared       asdasdasds
    │   ├─ main.dart    asdasdasd
    └─ linux/           asdasd
    |- macos/
    |- web/
    |- windows/
```


## Working with user settings
So you want to add a new option to settings? I got you covered

## Database

### Database structure

## Working with Isar
That guy, heh? It's best to leave him alone, his a real piece of work but he's the best we've got.

You're probaly thiniking right now: "I just want to make a simple query, stop with those theatrics already." Alright no need to be so rude about this, jeez. Let's start with [obtaining a ref](https://docs-v2.riverpod.dev/docs/concepts/reading#obtaining-a-ref-object). What's ref you ask? Idk, but you can use it to get isar to show to work, that deadbeat.

Okay now that you've grabbed your ref. You can get [Isar object](https://pub.dev/documentation/isar/latest/isar/Isar-class.html) like this.

```dart
  final isar = ref.watch(isarPod);
```

I won't go into details on inner workings of isar, you can go [RTFM](https://isar.dev/tutorials/quickstart.html). But I'll give you some tips on how to not stab yourself in a toe in the process. It hurts, trust me.

TODO