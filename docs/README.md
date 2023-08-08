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
So you want to add a new option to settings? What do we have today? We have it all: switches, sliders, or perhaps you fancy a dropdown? Whatever you've said I've got you covered. And if you're looking for something else, then I idk, but you'll figure it out. I believe in you. Cheers!

Now after this overaly long introduction and that those ungreatful bastards have left I'll show you how to add a new option in settings.

```dart
  const PersistentSwitch(
    "cheetah",
    title: Text("Do you know Jason Statham?"),
    subtitle: Text("How did you get into my basement???"),
    defaultValue: true
  ),
```

Go ahead paste that in `SettingsScreen`. Save the file, hot reload, and look you you did it. Now, when the user interacts with this widget, it's automagially saved to isar, so you don't have to worry about that part, neat, right?


But how can I retrieve a value stored in isar. For that you'll have to use SettingsManager. When in doubt [obtain a ref](https://docs-v2.riverpod.dev/docs/concepts/reading#obtaining-a-ref-object) you can use it get an instance of settings manager. You might be wondering why can't you create a new instance of settings manager yourself like that:

```
  final settingsManager = SettingsManager();
```

> An idiot admires complexity, a genius admires simplicity
>
> -- <cite>Terry Davis, Creator of Temple OS</cite>

And I'm a fucking idiot, so you'll do it my way or a highway.

```dart
  final didSomeoneBreakIntoMyBasement = await ref.watch(settingsManagerProvider).getValue("cheetah"); // can be null

  if (didSomeoneBreakIntoMyBasement == null || didSomeoneBreakIntoMyBasement) {
    // do something
  }
```

Why do I have to check if `didSomeoneBreakIntoMyBasement` is null? Shouldn't it be either true or false? Didn't I set the defaultValue to true? You said it'll be saved automagically? So where is it, you filthy liar?

I can understand where you're coming from, but you've got to stop yelling. I know what I said and it's true that when a user interacts with this widget it's current state we'll be saved to isar ..but a user has to interact with it first. If that doesn't happen than no value will be present in isar, and you'll have to handle scenerio when `didSomeoneBreakIntoMyBasement` is null. I know it quite nerve wracking but it is what it is, sorry. When a value is null you have to treat it as if it was equal to `defaultValue` that you passed to widget.

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
