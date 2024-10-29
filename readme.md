A REPL for C

Built for SE Hackday #13

## Instructions

```bash
git clone https://github.com/neilparikh/crepel
cd crepel
ruby crepel.rb
```

You should get a prompt, like follows:

```
crepel>
```

Type some C code in, and it will be evaluated.

## Example Session

```
crepel> int a = 4;
crepel> a++;
4
crepel> a;
5
crepel> int x_plus_5(int x) {
crepel> return x + 5;
crepel> }
crepel> x_plus_5(3);
8
crepel> x_plus_5(a);
10
```

## Requirements

You need g++ installed. Also, if you are on Windows, replace ```./a.out``` with ```./a.exe```.
