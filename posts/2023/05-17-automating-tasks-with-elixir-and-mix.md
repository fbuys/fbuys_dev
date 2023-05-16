%{
  title: "Automating tasks with Elixir and Mix",
  tags: ~w(elixir),
  author: "Francois Buys",
}
---

# Intro

[Elixir](https://elixir-lang.org/){: target='\_blank' rel='noreferrer noopener'} is easy to
learn and use and combined with [Mix](https://hexdocs.pm/mix/1.14/Mix.html) it is a great
tool for automating tedious or repetitive tasks. Follow along as we discuss the steps you
would take to automate a task, we will look at examples as well as alternatives.

<!-- more -->

# What and why

Have you ever had a tedious or repetitive task that you wished you could automate? Maybe
it's a task at work, or maybe it's something you do in your personal life. Whatever it is,
automating it could save you a lot of time and hassle.

In this blog post, we'll discuss practical steps for writing our very own Mix task. Mix
tasks are a great way to automate common tasks. They can be used to:

- Run commands
- Generate files
- Send emails
- And more!

_First, this post is not about creating a standalone command line application._ Instead,
we are taking a much simpler approach by looking at ways to use Mix tasks to automate
parts of our job or personal admin tasks.

This post also _assumes you have Erlang and Elixir already installed_ on your development
computer. 

With that out of the way, let us get started.

# How to get started

## Create a new app

Mix is a build tool that provides tasks for creating, compiling, testing Elixir projects,
and much more. To create a new Elixir app, follow these steps:

1. Open a terminal window and navigate to the directory where you want to create your app.
2. Run the following command:

```elixir
Mix new <app-name>
```

Replace `<app-name>` with the name of your app. For example, to create an app named
"my_app", you would run the following command:

```bash
$ Mix new my_app
```

Mix will create a new directory for your app, with the following files:

- `Mix.exs`: The project configuration file.
- `lib/my_app.ex`: The main module for your app.
- `test/my_app_test.exs`: The test suite for your app.

Mix new allows for more options to customize exactly how the project should be created.
To see these options you can run `Mix help new`.

Once done, remember to navigate into your project directory, for the above example we
would run the following command:

```
cd my_app
```

## Fetch dependencies

Elixir apps can depend on other Elixir libraries, called "dependencies". To fetch the dependencies for your app, run the following command:
```
Mix deps.get
```

This will download the latest versions of your dependencies and add them to your project.

## Add a task

To add a new task, follow these steps:
1. Create a new file in the `lib/Mix/tasks` directory.
2. Name the file after the task you want to create. For example, to create a task to parse
a CSV file, you would name the file `parse_csv.ex`.
3. In the file, define a module that starts with `Mix.Tasks`. For example:

```elixir
defmodule Mix.Tasks.ParseCsv do
  use Mix.Task
end
```
4. Define a `run/1` function in the module. This function will be called when the task
is executed. For example:

```elixir
defmodule Mix.Tasks.ParseCsv do
  use Mix.Task

  def run(args) do
    # Do something to parse the CSV file.
  end
end
```

5. You can now run the task by typing `Mix parse_csv` in the terminal. Mix will compile
the project before it runs the task.

Some things that you might note is:
- Every task module name starts with `Mix.Tasks`. - We also include `use Mix.Task` in
whenever we create a Mix task.
- A `run\1` function is required in a Mix task.
- You can use the `@shortdoc` and `@moduledoc` attributes to add a short description and
a longer description to your task, respectively. More about these attributes shortly.


Inside of the file we would create a module that contains the code required to complete
the task we are automating. If you need some inspiration you can go visit the
[tasks defined in the phoenix project](https://github.com/phoenixframework/phoenix/tree/main/lib/Mix/tasks){:target='\_blank' rel='noreferrer noopener'} we might even want to look at `Mix new` task we used to create our project [here](https://github.com/elixir-lang/elixir/blob/main/lib/Mix/lib/Mix/tasks/new.ex){:target='\_blank' rel='noreferrer noopener'}.

## Add help text

Help text is a great way to document your Mix tasks and make them easier to use. You can add help text to your tasks using the `@shortdoc` and `@moduledoc` attributes.

The `@shortdoc` attribute is used to add a short description of the task. This description will be displayed when the user runs the `Mix help` command. For example:
```elixer
@shortdoc "Creates a new Elixir project"
```

The `@moduledoc` attribute is used to add a longer description of the task. This description will be displayed when the user runs the `Mix help <task-name>` command. For example:
```elixir
@moduledoc """
Creates a new Elixir project.

Elaborates a bit on what it mean to create a new project.

## Examples

	$ Mix new hello_world
 
## Command line options

	* `-u`, `--umbrella` - generate an umbrella application
"""
```

I recommend that you always add help text to your Mix tasks. This will make your tasks easier to use and will help other people understand what your tasks do.

Here are some additional tips for writing good help text:

-   Keep the descriptions short and to the point.
-   Use clear and concise language.
-   Use examples to illustrate how the task can be used.
-   Be sure to document all of the task's options and switches.

Take a look at the `@shortdoc` and `@moduledoc` attributes from these repos. Notice that they contain clear explanations, usage examples and insight into the available command line options.

- [Elixir built in tasks](https://github.com/elixir-lang/elixir/tree/main/lib/Mix/lib/Mix/tasks){:target='\_blank' rel='noreferrer noopener'}
- [phoenixframework](https://github.com/phoenixframework/phoenix/tree/main/lib/Mix/tasks){:target='\_blank' rel='noreferrer noopener'}
- [absinthe](https://github.com/absinthe-graphql/absinthe/tree/master/lib/Mix/tasks){:target='\_blank' rel='noreferrer noopener'}
- [ecto](https://github.com/elixir-ecto/ecto/tree/master/lib/Mix/tasks){:target='\_blank' rel='noreferrer noopener'}

## Use OptionParser

[OptionParser](https://hexdocs.pm/elixir/OptionParser.html#content){:target='\_blank' rel='noreferrer noopener'}
is a built-in Elixir module that provides a simple way to parse command line arguments.
Command line arguments are often referred to as "switches" or "flags". An "argument"
refers to the value that is assigned to the switch.

OptionParser provides some conveniences out of the box, such as aliases and automatic
handling of negation switches and you can read more about them in the documentation.

The `parse/2` function accepts command line options and returns a keyword list of switches
and arguments. Below is an example showing how we could use `parse/2` to accept a `debug` flag:

```elixir
OptionParser.parse(["--debug"], strict: [debug: :boolean])
# ```
{[debug: true], [], []}
```

This will return a tuple of the form `{parsed, args, invalid}`. The `parsed` value is a
keyword list of parsed switches with `{switch_name, value}` tuples in it. The
`switch_name` is the atom representing the switch name while the `value` is the value for
that switch.

The `args` value is a list of arguments that were not parsed as switches. The `invalid`
value is a list of switches that were not recognized.

Here is an example of how we might use OptionParser in our `parse_csv` task:

```elixir
defmodule Mix.Tasks.ParseCsv do
  use Mix.Task

  @shortdoc "A short description of the parse_csv task."
  
  @moduledoc """
    Help text with examples and command line options.
  """

  @switches [
    file: :string,
    debug: :boolean
  ]

  def run(args) do
    {parsed, _, _} = OptionParser.parse(args, switches: @switches)

    # Do something with the parsed switches and arguments.
  end
end
```

## Testing

Testing a Mix task with ExUnit is no different from any other testing that we might do,
but there are 3 things we would need to do to write our tests:

- **Run the task.** In our tests we would make assertions against the output of our task.
Naturally, we would need to execute or run the task to have output to assert against.
- **Capture the output.** A Mix task often outputs data to the command line (standard
output). If this is the case for your task then you would need to capture this output so
we can make assertions against it. 
- **Make assertions against the output.** Once we have captured the output of the task,
we can make assertions against it to ensure that it is correct.

```elixir
# Get Mix output sent to the current
# process to avoid polluting tests.
Mix.shell(Mix.Shell.Process)

defmodule Mix.Tasks.ParseCsvTest do
  use ExUnit.Case, async: true

  describe "run/1" do
    test "outputs parsed csv data" do
      # Run the task.
      Mix.Tasks.ParseCsv.run(["--file", "tmp/my_file.csv"])

      # Capture the output.
	  assert_received {:Mix_shell, :info, [output]}

      # Make assertions against the output.
      assert output == """
               Acc Name, 2023/05/02, Food, , 280.00
               """
    end
  end
end
```

To prevent polluting test output we swap the default shell with a test shell that sends
the output to our current test process.

```ellixir
# Get Mix output sent to the current
# process to avoid polluting tests.
Mix.shell(Mix.Shell.Process)
```

Notice how we include command line options, `--file tmp/my_file.csv` in the run step of
our test.

The [`assert_receive`](https://hexdocs.pm/ex_unit/1.12/ExUnit.Assertions.html#assert_receive/3){:target='\_blank' rel='noreferrer noopener'}
assertions is particularly well suited for capturing messages sent to the shell. It has
the added benefit of allowing us to pattern match on the message, command line output in
this case, that we expect to receive.

# Elixir for CLI applications

Are you interested in creating a command line application? If so, you might want to
explore ElixirScript. ExlixirScript files have the `.exs` file extension. However, it's
important to note that ElixirScript has certain limitations, such as the lack of
straightforward inclusion of other modules.

To overcome some of these limitations, you can consider investigating Escript. Escript
enables the distribution of your entire Elixir project as a standalone executable, which
can be beneficial for command line applications.

Another tool worth exploring is [Burrito](https://github.com/burrito-elixir/burrito){:target='\_blank' rel='noreferrer noopener'}.
It allows you to build an Elixir command line application that can be distributed across
various operating systems like Linux, macOS, or Windows.

One drawback of Elixir command line applications is their relatively long startup time.
Consequently, they may not be the most ideal choice for applications where startup time is
a critical concern. However, in cases where startup time is not a significant factor,
delving into Elixir can be highly rewarding.

# Conclusion

Elixir is a powerful programming language that can be used to create a variety of
applications. In this post post, we have discussed how to create a new Elixir project,
add a task, use OptionParser and then how to test a task. 

We briefly looked at ElixirScript, Escript and Burrito to create command-line applications.

I hope this blog post has been helpful in guiding you to use Elixir and Mix to automate
tasks that you previously performed manually. 

# References

- [Learn more about escript](https://hexdocs.pm/Mix/1.14/Mix.Tasks.Escript.Build.html){:target='\_blank' rel='noreferrer noopener'}.
- [Learn more about OptionParser](https://hexdocs.pm/elixir/OptionParser.html){:target='\_blank' rel='noreferrer noopener'}.
- [Learn more about creating an Elixir CLI application that is cross-platform compatible](https://blog.appsignal.com/2022/08/09/write-a-standalone-cli-application-in-elixir.html){:target='\_blank' rel='noreferrer noopener'}. 
- [Here is an alternative approach to create a CLI application](https://blog.davemartin.me/posts/building-a-cli-application-in-elixir/){:target='\_blank' rel='noreferrer noopener'}.
- [Learn about the pitfalls when testing  Mix task](Learn about the pitfalls when testing  Mix task){:target='\_blank' rel='noreferrer noopener'}.





