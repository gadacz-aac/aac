# What's Gadacz?

It's an AAC app. 
And what's AAC, you ask? It stands for Aletnative Augmentive Communication and it's a set of tools that can be used for people with speech impediments to communicate with others.

Apps like this aren't their only choice and it might not be the best fit for everyone
...but for ones it works for it's a life saver - or at least a huge help in day to day life. 

For primary english speaking people reading this. Don't worry about prouncing the name. You won't.

## Why there're so many errors? I've just cloned this repo!!

Before you can start coding you have to run these two commands. They'll download all of the packages you need and generate files used by [isar](https://isar.dev/tutorials/quickstart.html#_3-run-code-generator).

```bash
flutter pub get
dart run build_runner build
```

## Something isn't working

If you just merged from another branch, or if you're haunted by many a strange errors. It be could a good idea to open your terminal and run these commands in project's main directory. It's not a silver bullet but who knows - it might just save you from hours of painful debuging.

```bash
flutter clean
flutter pub get
```

And while we're at that, why not remove all of the *.g.dart files genereted by build_runner. You can either do so manually or from command line

```bash
dart run build_runner clean
```


## The errors won't go away! What do i do?

If the above steps didn't help you it's propably something you did that upset Dash. Why don't yeh 'ave some watah and go faw a walk, mate? Remember that you can always ask for help on discord.


Drink plenty of coffee and happy coding!
