OrderCols
=========

Orders columns of a file from a given list of column names.

Usage
-----

```shell
sh ordercols.sh list_file input_file [Separator]
```

Example
-----

### List file

    A       B       C       D       E

This is the order you want to get from your input file.

### Input file

    C       D       B       E       A
    1       2       3       4       5

This is the input file that you want to sort.
The column names must match those in the list file.

### Calling

`sh ordercols.sh list1.txt input1.txt`

Here, we don't need to specify the separator, as the default one is "\t".

### Output

    A       B       C       D       E
    5       3       1       2       4

Options
-----

### Separator

By default the separator is "\t".

But you can specify your own separator, like this :
`sh ordercols.sh list2.txt input2.txt ";"`

What it does
=====

Basically, we are constructing an awk command from several tools in the shell.

This command is then sent to a file and executed.

If you look at the code, you'll see that's it's a bunch of tricks and not elegant. But it works.

I'm opened to suggestions !
