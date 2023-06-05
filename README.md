# basic-C-syntax-analizer
a basic parser of the C programming language, using lexx and yacc

## Grammar 🔏

The following are the tokens that are part of the set to take into account:
start({),if-else-fif,for-ffor,mq-fmq,hh-fhh,dd-fdd (depending on),read,write,end
Arithmetic operators: op-mult(*), op-sum(+), op-sust(-), op-div(/), op-mod(%)

Assignment: op-assign(=)

Take into account the syntax of an internal instruction regarding its termination, that is, if
ends with a semicolon, semicolon, or nothing.

The following symbols: parent-a ( ( ), parent-c ( ) ), comma (,), where necessary.

The following tokens: Integer constants, reals, strings (strings are enclosed in quotes
double quotes) and characters (characters are enclosed in single quotes).

The lexical components of the variables: Identifiers.

The lexical components of comparison: Equal (==), Different (!=) Less-equal (<=),
Greater-equal (>=), Greater (>) and Less (<).

Boolean operators: And ( && ), Or ( || ), Not ( ! ).

Comments within each of the programs should be considered.

The following variable declarations are considered: int, float, char. these are words
C programming language keys.

### **You should not consider:**

Handling arrays of any dimension.
string handling
Handling functions or subroutines
Management of predefined functions.

## Use 🚀

### requirements 📋

- Linux
- bison
- flex
- gcc

### Run 🔧

#### 1. sh file
1. run the _compile.sh_ file
  ```shell
  chmod +x compile.sh
  ./compile.sh
  ```
  And follow the steps indicated
2. Run the executable
  ```bash
  ./a.out [Input file]
  ```

#### 2. Compile yourself
Steps for compiling the program:
```
yacc -d test.y
lex test.l y.tab.h
cc -o a.out lex.yy.c y.tab.c
```
To run the program:

./a.out [Input file]

## Built with 🛠️

* Visual Studio Code - IDE
* Linux
* Lex
* yacc
* C

## Author ✒️

* **Leonardo Lizcano P.** - [LeoLizc ](https://github.com/LeoLizc )
