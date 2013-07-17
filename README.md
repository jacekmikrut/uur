uur
===

**uur** is a command-line tool that reads time log entries from a text file and then generates simple reports.

Workflow
--------
1. One adds time entries to `~/.uur/entries` file using one's favourite text editor.
2. Then at any time one can use **uur** to print reports.

Entries file
------------

The entries file should be created at `~/.uur/entries` by the user. 

Each line in this file corresponds to one time entry and has the following format:
```
YYYY-MM-DD hh:mm - hh:mm Project name  Entry description.
```
- the above data fields should be separated by at least one whitespace character; 
- the project name should be separated from the entry description by at least two whitespace characters.

An example: 
```
2013-07-17 10:15 - 10:45 Uur  Writing README file content.
```

Blank lines and those that start with `#` (hash) sign are ignored.

Reports
-------

There are two types of reports: entry lists and entry summaries.

#### Entries list report

Simply prints the entries within the specified period, grouped by day.

An example:
```
> uur --list --within last-month
Mon, 10 June 2013
09:15 - 11:45 2h30m Project A Working on task A1
11:45 - 12:15   30m Project B Working on task B1
15:00 - 16:00 1h00m Project B Completed task A1
       Total: 4h00m

Tue, 11 June 2013
08:45 - 12:00 3h15m Project A Completed task B1
       Total: 3h15m
       
...
```

#### Entries summary report

Prints the sum of hours spent on each of the projects within the specified period grouped by the specified interval.

An example:
```
> uur --summary monthly --within this-year
January 2013
Project A  12h15m
Project B 120h30m
Project C   6h00m
Total:    138h45m

February 2013
Project B 140h00m
Project C   8h30m
Total:    148h30m

...
```

Usage
-----

```
uur [options]

Reports:
  -l, --list                                         List entries
  -s, --summary [daily|weekly|monthly|yearly|all]    Print summary

Filtering:
  -w, --within today|yesterday|this-week|            Time period (default: today)
               last-week|this-month|last-month|
               this-year|last-year
    
Common options:
  -d, --duration-format hours-minutes|hours-decimal  Duration time format (default: hours-minutes)

Others:
  -h, --help      Show this help message
      --version   Show version
```

Installation
------------

```
  gem install uur
  mkdir ~/.uur
  touch ~/.uur/entries
```

Author
------

[Jacek Mikrut](https://github.com/jacekmikrut)

License
-------

License is included in the LICENSE file.
