
# HolyWaterBooks

HolyWaterBooks test task [HolyWater] IT company.

# Getting Started

These instructions will get you a copy of the project up and running on your local machine for development and testing purposes.

## Prerequisites

### Xcode

First you need to install the latest Xcode version, you can find it [here](https://developer.apple.com/download/all/)

### Homebrew

Install Homebrew:

```
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```

### SwiftFormat

SwiftFormat install
```
brew install swiftlint
```
or [here](https://github.com/nicklockwood/SwiftFormat)

### Swiftlint

Swiftlint install 

```
brew install swiftformat
```

```
brew upgrade swiftformat
```

or [here](https://github.com/realm/SwiftLint)

To run Swiftlint use:

```
swiftlint
```

# SwiftLint

In order to lint the project, run the following command from the command line:
```
swiftlint lint --quiet
```

Optionally, you can also specify `-path ./path/to/some_file.swift` if you want to lint only a specified file or directory.

# Pre-commit hooks

HolyWaterBooks is using a git pre-commit hook which keeps the code clean and well formatted right in development time.

1. Install pre-commit hook manager and ensure that it installed properly:

```
brew install pre-commit
pre-commit --version
```

2. In-app directory run the pre-commit installation

```
pre-commit install
```

Once pre-commit is installed you can run it manually with the command:

```
pre-commit
```

Or you can skip it, the pre-commit hook will run every single time with the **git commit**

**OPTIONAL:** It’s also possible to run pre-commits on all files, using the appropriate flag:

```pre-commit run —all-files // not recommended ```

### IMPORTANT: Every time when pre-commit fails your changes are **unstaged!**

All hooks are configured in **.pre-commit-config.yaml** and reads directly from swiftlint and swiftformat configuration files. Once any of them is updated pre-commit is updated either.
