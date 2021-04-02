# Some exemples of "complex" Regex I've written
Some are related to online lessons. Other are just the result of challenges invented by myself.

## Numeric
### Search all numbers with negative sign, commas, dot, scientific notation.
```
/^-?(\d+)(,\d+)*(\.\d+(e\d+)?)?$/gm
```
Tests
```
# Match
3.14529
234,234,234,234.2244e10
-255.34
128
-344.4
-2
1.9e10
123,340.00
# Skip
720p
033.
3e,3,55.4
234,34,34,23,,,3243.14529
```

### Phonenumber validation
A partial try
```
/((\d )|\()?(\d{3})([ \-\)])?(\d{3})([\- ])?(\d{4})/gm
```
```
415-555-1234
650-555-2345
(416)555-3456
202 555 4567
4035555678
1 416 555 9292
```

### Email validation
Only a try. Not usable in real software. Majority of programming languages already have functions or means to validate emails.

```
/^([A-Za-z.]+)(\+[A-Za-z.]+)?@([A-Za-z]+)(.[A-Za-z\-]+)*$/gm
```

```
tom@hogwarts.com
tom.riddle@hogwarts.com
tom.riddle+regexone@hogwarts.com
tom@hogwarts.eu.com
potter@hogwarts.com
harry@hogwarts.com
hermione+regexone@hogwarts.com 	hermione
```