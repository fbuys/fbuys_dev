---
title: "All the little things"
published_on: 2020-12-20
---

I wrote this post inspired by [Sandi Metz](https://sandimetz.com/about){:target='\_blank' rel='noreferrer noopener'}, a legend in the object-oriented design community. [All the little things](https://www.youtube.com/watch?v=8bZh5LMaSmE){:target='\_blank' rel='noreferrer noopener'} is a talk suggested to me by [Chris Toomey](https://ctoomey.com){:target='\_blank' rel='noreferrer noopener'} and I owe him for doing so. It made a significant impact on me and I would love to share some of the insights I gained.

<!-- more -->

## TLDR;

- ✅ Make smaller things
- ✅ Find problematic code using the squint test
- ✅ Prefer duplication over wrong abstractions
- ✅ Add behaviour without changing existing code
- ✅ Inheritance is not evil
- ✅ Rearrange code without changing the behavoir

## Make smaller things

Sandi is right when she says that we often come to hate our code. To improve or prevent this situation, she suggests that we _make smaller things_. In practice, it means that we should make smaller methods and smaller classes that know as little about each other as possible.

What should you do next time you face challenging code? First, you should refactor the code into smaller methods and then into smaller objects.

> Small methods are easy _Sandi Metz_

## Find problematic code using the squint test

Sandi presents a technique she named the squint test. It is a method for finding code that could most easily be improved. Follow these steps:
1. Squint and lean back.
2. Look for code with an irregular shape (levels of indentation).
3. Look for changes in colors (added by  the syntax highlighter)

Code with an irregular shape usually contains conditionals that can be simplified. Similarly, when we notice code with different colors grouped together it means varying levels of abstraction. _We want flat shapes and colors to group together._

## Prefer duplication over wrong abstractions

Sandy urges us to resist the temptation to get rid of duplication too soon. Intermediate developers can tolerate duplicate code while we wait for the code to provide us with more insight. We wait until the right abstraction becomes apparent before we implement it.

We can tag our duplicated code with "Dup Tag" comments. Each comment can give the duplicated code an ID. We will soon notice the same dup tag in different places.

> Duplication is far cheaper than the wrong abstraction _Sandi Metz_

## Add behaviour without changing existing code

The Open/Closed principle forms the O of SOLID, and it states that we should be able to add new behaviour without editing existing code. In practical terms this means that when we see repeating prefixes or suffixes we need to look at adding a new class/object.

Let us take a moment and imagine, as Sandi suggests, a world where we can add new features without needing to modify existing code. No more breaking changes. No more far reaching side effects. No more shotgun surgeries. Dare I say, joyful code.

## Inheritance is not evil

Contrary to what many of us have been told, inheritance is not evil. It remains our responsibility to use inheritance appropriately. We want our subclasses to be on the leave nodes (so that means one level of inheritance). And we want our subclasses to use all the code from their super/parent classes.

> Stick to shallow and narrow inheritance hierarchies _Sandi Metz_

## Rearrange code without changing the behavoir

Sandi reminds us of the true definition of refactoring. _To refactor is to change the arrangement of the code, without altering the behavoir_. We should always remember that we can only refactor if we have reliable tests.

The alterantive, when we don't trust our tests, is to keep code as it is forever. Sandi insists that keeping code around forever is not a good choice.

> Make the change easy, then make the easy change _Kent Beck_

## Conclusion
Don't be afraid to create smaller things. We need to understand the principles of object oriented design and trust the value of smaller methods and classes. These two things will give us the courage to push through the complexity that refactoring temporarily adds.
