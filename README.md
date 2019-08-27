Latitude JS Style Guide
=======================

<!--### Avoid Long/Complicated Ternaries-->
<!--- Keep it simple 😉-->
<!--- Should be *at most* 100 characters long-->
<!--- **NEVER** nest ternaries within ternaries-->

<!--**When to use `if` instead**-->
<!-->For example, if a ternary usage looks like:-->
<!-->```javascript-->
<!-->return (array.length && thingIsTrue) ? (array.length > 3 ? 'enough data' : 'not enough data') : 'no data'-->
<!-->```-->
<!-->it should be re-written to something like:-->
<!-->```javascript-->
<!-->if(array.length && thingIsTrue) {-->
<!-->    if(array.length > 3) {-->
<!-->        return 'enough data'-->
<!-->    }-->
<!-->    return 'not enough data'-->
<!-->}-->
<!-->return 'no data'-->
<!-->```-->

<!--**An example of a reasonable usage**-->
<!-->```javascript-->
<!-->return thingIsTrue ? 'so true' : 'not so true'-->
<!-->```-->


## Promises

  - Always chain standard promises

    > Why? Nested Promises are hideous

    ```javascript

    // very very bad
    doThing1()
        .then(() => {
            doThing2()
                .then(() => {
                    doThing3()
                        .then(() => {
                            console.log('all things are done');
                        })
                        .catch(console.log)
                })
                .catch(console.log)
        })
        .catch(console.log);


    // still bad
    doThing1()
        .then(() => {
            return doThing2()
                .then(() => {
                    return doThing3()
                        .then(() => {
                            console.log('all things are done');
                        })
                })
        })
        .catch(console.log);


    // good
    doThing1()
        .then(() => {
            return doThing2()
        })
        .then(() => {
            return doThing3()
        })
        .then(() => {
            console.log('all things are done');
        })
        .catch(console.log);


    // handling an individual promise error
    doThing1()
        .then(() => {
            return doThing2().catch(e => {
                console.log('thing two failed');
                throw(e);
            })
        })
        .then(() => {
            return doThing3()
        })
        .then(() => {
            console.log('all things are done');
        })
        .catch(console.log);

    ```

## References

  - Use `const` for all of your references; avoid using `var`. eslint: [`prefer-const`](https://eslint.org/docs/rules/prefer-const.html), [`no-const-assign`](https://eslint.org/docs/rules/no-const-assign.html)

    > Why? This ensures that you can’t reassign your references, which can lead to bugs and difficult to comprehend code.

    ```javascript
    // bad
    var a = 1;
    var b = 2;

    // good
    const a = 1;
    const b = 2;
    ```

  - If you must reassign references, use `let` instead of `var`. eslint: [`no-var`](https://eslint.org/docs/rules/no-var.html)

    > Why? `let` is block-scoped rather than function-scoped like `var`.

    ```javascript
    // bad
    var count = 1;
    if (true) {
      count += 1;
    }

    // good, use the let.
    let count = 1;
    if (true) {
      count += 1;
    }
    ```

## Objects

  - Use object method shorthand. eslint: [`object-shorthand`](https://eslint.org/docs/rules/object-shorthand.html)

    ```javascript
    // bad
    const atom = {
      value: 1,

      addValue: function (value) {
        return atom.value + value;
      },
    };

    // good
    const atom = {
      value: 1,

      addValue(value) {
        return atom.value + value;
      },
    };
    ```

  
  - Use property value shorthand. eslint: [`object-shorthand`](https://eslint.org/docs/rules/object-shorthand.html)

    > Why? It is shorter and descriptive.

    ```javascript
    const lukeSkywalker = 'Luke Skywalker';

    // bad
    const obj = {
      lukeSkywalker: lukeSkywalker,
    };

    // good
    const obj = {
      lukeSkywalker,
    };
    ```


  - Group your shorthand properties at the beginning of your object declaration.

    > Why? It’s easier to tell which properties are using the shorthand.

    ```javascript
    const anakinSkywalker = 'Anakin Skywalker';
    const lukeSkywalker = 'Luke Skywalker';

    // bad
    const obj = {
      episodeOne: 1,
      twoJediWalkIntoACantina: 2,
      lukeSkywalker,
      episodeThree: 3,
      mayTheFourth: 4,
      anakinSkywalker,
    };

    // good
    const obj = {
      lukeSkywalker,
      anakinSkywalker,
      episodeOne: 1,
      twoJediWalkIntoACantina: 2,
      episodeThree: 3,
      mayTheFourth: 4,
    };
    ```
  <a name="objects--rest-spread"></a>
  - [3.8](#objects--rest-spread) Prefer the object spread operator over [`Object.assign`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Object/assign) to shallow-copy objects. Use the object rest operator to get a new object with certain properties omitted.

    ```javascript
    // very bad
    const original = { a: 1, b: 2 };
    const copy = Object.assign(original, { c: 3 }); // this mutates `original` ಠ_ಠ
    delete copy.a; // so does this

    // bad
    const original = { a: 1, b: 2 };
    const copy = Object.assign({}, original, { c: 3 }); // copy => { a: 1, b: 2, c: 3 }

    // good
    const original = { a: 1, b: 2 };
    const copy = { ...original, c: 3 }; // copy => { a: 1, b: 2, c: 3 }

    const { a, ...noA } = copy; // noA => { b: 2, c: 3 }
    ```

## Arrays
  <a name="es6-array-spreads"></a><a name="4.3"></a>
  - [4.3](#es6-array-spreads) Use array spreads `...` to copy arrays.

    ```javascript
    // bad
    const len = items.length;
    const itemsCopy = [];
    let i;

    for (i = 0; i < len; i += 1) {
      itemsCopy[i] = items[i];
    }

    // good
    const itemsCopy = [...items];
    ```
  <a name="arrays--mapping"></a>
  - [4.6](#arrays--mapping) Use [`Array.from`](https://developer.mozilla.org/en/docs/Web/JavaScript/Reference/Global_Objects/Array/from) instead of spread `...` for mapping over iterables, because it avoids creating an intermediate array.

    ```javascript
    // bad
    const baz = [...foo].map(bar);

    // good
    const baz = Array.from(foo, bar);
    ```
  <a name="arrays--bracket-newline"></a>
  - [4.8](#arrays--bracket-newline) Use line breaks after open and before close array brackets if an array has multiple lines

    ```javascript
    // bad
    const arr = [
      [0, 1], [2, 3], [4, 5],
    ];

    const objectInArray = [{
      id: 1,
    }, {
      id: 2,
    }];

    const numberInArray = [
      1, 2,
    ];

    // good
    const arr = [[0, 1], [2, 3], [4, 5]];

    const objectInArray = [
      {
        id: 1,
      },
      {
        id: 2,
      },
    ];

    const numberInArray = [
      1,
      2,
    ];
    ```
## Destructuring
  <a name="destructuring--object"></a><a name="5.1"></a>
  - [5.1](#destructuring--object) Use object destructuring when accessing and using multiple properties of an object. eslint: [`prefer-destructuring`](https://eslint.org/docs/rules/prefer-destructuring)

    > Why? Destructuring saves you from creating temporary references for those properties.

    ```javascript
    // bad
    function getFullName(user) {
      const firstName = user.firstName;
      const lastName = user.lastName;

      return `${firstName} ${lastName}`;
    }

    // good
    function getFullName(user) {
      const { firstName, lastName } = user;
      return `${firstName} ${lastName}`;
    }

    // best
    function getFullName({ firstName, lastName }) {
      return `${firstName} ${lastName}`;
    }
    ```
## Strings
   <a name="strings--quotes"></a><a name="6.1"></a>
   - [6.1](#strings--quotes) Use single quotes `''` for strings. eslint: [`quotes`](https://eslint.org/docs/rules/quotes.html)

     ```javascript
     // bad
     const name = "Capt. Janeway";

     // bad - template literals should contain interpolation or newlines
     const name = `Capt. Janeway`;

     // good
     const name = 'Capt. Janeway';
     ```
  <a name="es6-template-literals"></a><a name="6.4"></a>
  - [6.3](#es6-template-literals) When programmatically building up strings, use template strings instead of concatenation. eslint: [`prefer-template`](https://eslint.org/docs/rules/prefer-template.html) [`template-curly-spacing`](https://eslint.org/docs/rules/template-curly-spacing)

    > Why? Template strings give you a readable, concise syntax with proper newlines and string interpolation features.

    ```javascript
    // bad
    function sayHi(name) {
      return 'How are you, ' + name + '?';
    }

    // bad
    function sayHi(name) {
      return ['How are you, ', name, '?'].join();
    }

    // bad
    function sayHi(name) {
      return `How are you, ${ name }?`;
    }

    // good
    function sayHi(name) {
      return `How are you, ${name}?`;
    }
    ```
## Functions
  <a name="functions--declarations"></a><a name="7.1"></a>
  - [7.1](#functions--declarations) Use named function expressions instead of function declarations. eslint: [`func-style`](https://eslint.org/docs/rules/func-style)

    > Why? Function declarations are hoisted, which means that it’s easy - too easy - to reference the function before it is defined in the file. This harms readability and maintainability. If you find that a function’s definition is large or complex enough that it is interfering with understanding the rest of the file, then perhaps it’s time to extract it to its own module! Don’t forget to explicitly name the expression, regardless of whether or not the name is inferred from the containing variable (which is often the case in modern browsers or when using compilers such as Babel). This eliminates any assumptions made about the Error’s call stack. ([Discussion](https://github.com/airbnb/javascript/issues/794))

    ```javascript
    // bad
    function foo() {
      // ...
    }

    // bad
    const foo = function () {
      // ...
    };

    // good
    // lexical name distinguished from the variable-referenced invocation(s)
    const short = function longUniqueMoreDescriptiveLexicalFoo() {
      // ...
    };
    ```
  <a name="es6-default-parameters"></a><a name="7.7"></a>
  - [7.7](#es6-default-parameters) Use default parameter syntax rather than mutating function arguments.

    ```javascript
    // really bad
    function handleThings(opts) {
      // No! We shouldn’t mutate function arguments.
      // Double bad: if opts is falsy it'll be set to an object which may
      // be what you want but it can introduce subtle bugs.
      opts = opts || {};
      // ...
    }

    // still bad
    function handleThings(opts) {
      if (opts === void 0) {
        opts = {};
      }
      // ...
    }

    // good
    function handleThings(opts = {}) {
      // ...
    }
    ```
  <a name="functions--defaults-last"></a><a name="7.9"></a>
  - [7.9](#functions--defaults-last) Always put default parameters last.

    ```javascript
    // bad
    function handleThings(opts = {}, name) {
      // ...
    }

    // good
    function handleThings(name, opts = {}) {
      // ...
    }
    ```
  <a name="functions--mutate-params"></a><a name="7.12"></a>
  - [7.12](#functions--mutate-params) Never mutate parameters. eslint: [`no-param-reassign`](https://eslint.org/docs/rules/no-param-reassign.html)

    > Why? Manipulating objects passed in as parameters can cause unwanted variable side effects in the original caller.

    ```javascript
    // bad
    function f1(obj) {
      obj.key = 1;
    }

    // good
    function f2(obj) {
      const key = Object.prototype.hasOwnProperty.call(obj, 'key') ? obj.key : 1;
    }
    ```
  <a name="functions--reassign-params"></a><a name="7.13"></a>
  - [7.13](#functions--reassign-params) Never reassign parameters. eslint: [`no-param-reassign`](https://eslint.org/docs/rules/no-param-reassign.html)

    > Why? Reassigning parameters can lead to unexpected behavior, especially when accessing the `arguments` object. It can also cause optimization issues, especially in V8.

    ```javascript
    // bad
    function f1(a) {
      a = 1;
      // ...
    }

    function f2(a) {
      if (!a) { a = 1; }
      // ...
    }

    // good
    function f3(a) {
      const b = a || 1;
      // ...
    }

    function f4(a = 1) {
      // ...
    }
    ```
  <a name="functions--signature-invocation-indentation"></a>
  - [7.15](#functions--signature-invocation-indentation) Functions with multiline signatures, or invocations, should be indented just like every other multiline list in this guide: with each item on a line by itself, with a trailing comma on the last item. eslint: [`function-paren-newline`](https://eslint.org/docs/rules/function-paren-newline)

    ```javascript
    // bad
    function foo(bar,
                 baz,
                 quux) {
      // ...
    }

    // good
    function foo(
      bar,
      baz,
      quux,
    ) {
      // ...
    }

    // bad
    console.log(foo,
      bar,
      baz);

    // good
    console.log(
      foo,
      bar,
      baz,
    );
    ```
## Arrow Functions

  <a name="arrows--use-them"></a><a name="8.1"></a>
  - [8.1](#arrows--use-them) When you must use an anonymous function (as when passing an inline callback), use arrow function notation. eslint: [`prefer-arrow-callback`](https://eslint.org/docs/rules/prefer-arrow-callback.html), [`arrow-spacing`](https://eslint.org/docs/rules/arrow-spacing.html)

    > Why? It creates a version of the function that executes in the context of `this`, which is usually what you want, and is a more concise syntax.

    > Why not? If you have a fairly complicated function, you might move that logic out into its own named function expression.

    ```javascript
    // bad
    [1, 2, 3].map(function (x) {
      const y = x + 1;
      return x * y;
    });

    // good
    [1, 2, 3].map((x) => {
      const y = x + 1;
      return x * y;
    });
    ```

  <a name="arrows--implicit-return"></a><a name="8.2"></a>
  - [8.2](#arrows--implicit-return) If the function body consists of a single statement returning an [expression](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Expressions_and_Operators#Expressions) without side effects, omit the braces and use the implicit return. Otherwise, keep the braces and use a `return` statement. eslint: [`arrow-parens`](https://eslint.org/docs/rules/arrow-parens.html), [`arrow-body-style`](https://eslint.org/docs/rules/arrow-body-style.html)

    > Why? Syntactic sugar. It reads well when multiple functions are chained together.

    ```javascript
    // bad
    [1, 2, 3].map((number) => {
      const nextNumber = number + 1;
      `A string containing the ${nextNumber}.`;
    });

    // good
    [1, 2, 3].map((number) => `A string containing the ${number + 1}.`);

    // good
    [1, 2, 3].map((number) => {
      const nextNumber = number + 1;
      return `A string containing the ${nextNumber}.`;
    });

    // good
    [1, 2, 3].map((number, index) => ({
      [index]: number,
    }));

    // No implicit return with side effects
    function foo(callback) {
      const val = callback();
      if (val === true) {
        // Do something if callback returns true
      }
    }

    let bool = false;

    // bad
    foo(() => bool = true);

    // good
    foo(() => {
      bool = true;
    });
    ```
  <a name="arrows--paren-wrap"></a><a name="8.3"></a>
  - [8.3](#arrows--paren-wrap) In case the expression spans over multiple lines, wrap it in parentheses for better readability.

    > Why? It shows clearly where the function starts and ends.

    ```javascript
    // bad
    ['get', 'post', 'put'].map((httpMethod) => Object.prototype.hasOwnProperty.call(
        httpMagicObjectWithAVeryLongName,
        httpMethod,
      )
    );

    // good
    ['get', 'post', 'put'].map((httpMethod) => (
      Object.prototype.hasOwnProperty.call(
        httpMagicObjectWithAVeryLongName,
        httpMethod,
      )
    ));
    ```
## Classes & Constructors

  <a name="constructors--use-class"></a><a name="9.1"></a>
  - [9.1](#constructors--use-class) Always use `class`. Avoid manipulating `prototype` directly.

    > Why? `class` syntax is more concise and easier to reason about.

    ```javascript
    // bad
    function Queue(contents = []) {
      this.queue = [...contents];
    }
    Queue.prototype.pop = function () {
      const value = this.queue[0];
      this.queue.splice(0, 1);
      return value;
    };

    // good
    class Queue {
      constructor(contents = []) {
        this.queue = [...contents];
      }
      pop() {
        const value = this.queue[0];
        this.queue.splice(0, 1);
        return value;
      }
    }
    ```


## Modules
  <a name="modules--prefer-default-export"></a>
  - [10.6](#modules--prefer-default-export) In modules with a single export, prefer default export over named export.
 eslint: [`import/prefer-default-export`](https://github.com/benmosher/eslint-plugin-import/blob/master/docs/rules/prefer-default-export.md)
    > Why? To encourage more files that only ever export one thing, which is better for readability and maintainability.

    ```javascript
    // bad
    export function foo() {}

    // good
    export default function foo() {}
    ```


  <a name="modules--multiline-imports-over-newlines"></a>
  - [10.8](#modules--multiline-imports-over-newlines) Multiline imports should be indented just like multiline array and object literals.

    > Why? The curly braces follow the same indentation rules as every other curly brace block in the style guide, as do the trailing commas.

    ```javascript
    // bad
    import {thingA, thingB, thingC, thingD, thingE} from 'path';

    // good
    import {
      thingA,
      thingB,
      thingC,
      thingD,
      thingE,
    } from 'path';
    ```
## Variables
  <a name="variables--one-const"></a><a name="13.2"></a>
  - [13.2](#variables--one-const) Use one `const` or `let` declaration per variable or assignment. eslint: [`one-var`](https://eslint.org/docs/rules/one-var.html)

    > Why? It’s easier to add new variable declarations this way, and you never have to worry about swapping out a `;` for a `,` or introducing punctuation-only diffs. You can also step through each declaration with the debugger, instead of jumping through all of them at once.

    ```javascript
    // bad
    const items = getItems(),
        goSportsTeam = true,
        dragonball = 'z';

    // bad
    // (compare to above, and try to spot the mistake)
    const items = getItems(),
        goSportsTeam = true;
        dragonball = 'z';

    // good
    const items = getItems();
    const goSportsTeam = true;
    const dragonball = 'z';
    ```
  <a name="variables--define-where-used"></a><a name="13.4"></a>
  - [13.4](#variables--define-where-used) Assign variables where you need them, but place them in a reasonable place.

    > Why? `let` and `const` are block scoped and not function scoped.

    ```javascript
    // bad - unnecessary function call
    function checkName(hasName) {
      const name = getName();

      if (hasName === 'test') {
        return false;
      }

      if (name === 'test') {
        this.setName('');
        return false;
      }

      return name;
    }

    // good
    function checkName(hasName) {
      if (hasName === 'test') {
        return false;
      }

      const name = getName();

      if (name === 'test') {
        this.setName('');
        return false;
      }

      return name;
    }
    ```
## Comparison Operators & Equality

  <a name="comparison--eqeqeq"></a><a name="15.1"></a>
  - [15.1](#comparison--eqeqeq) Use `===` and `!==` over `==` and `!=`. eslint: [`eqeqeq`](https://eslint.org/docs/rules/eqeqeq.html)

  <a name="comparison--if"></a><a name="15.2"></a>
  - [15.2](#comparison--if) Conditional statements such as the `if` statement evaluate their expression using coercion with the `ToBoolean` abstract method and always follow these simple rules:

    - **Objects** evaluate to **true**
    - **Undefined** evaluates to **false**
    - **Null** evaluates to **false**
    - **Booleans** evaluate to **the value of the boolean**
    - **Numbers** evaluate to **false** if **+0, -0, or NaN**, otherwise **true**
    - **Strings** evaluate to **false** if an empty string `''`, otherwise **true**

    ```javascript
    if ([0] && []) {
      // true
      // an array (even an empty one) is an object, objects will evaluate to true
    }
    ```
  <a name="comparison--shortcuts"></a><a name="15.3"></a>
  - [15.3](#comparison--shortcuts) Use shortcuts for booleans, but explicit comparisons for strings and numbers.

    ```javascript
    // bad
    if (isValid === true) {
      // ...
    }

    // good
    if (isValid) {
      // ...
    }

    // bad
    if (name) {
      // ...
    }

    // good
    if (name !== '') {
      // ...
    }

    // bad
    if (collection.length) {
      // ...
    }

    // good
    if (collection.length > 0) {
      // ...
    }
    ```
  <a name="comparison--switch-blocks"></a><a name="15.5"></a>
  - [15.5](#comparison--switch-blocks) Use braces to create blocks in `case` and `default` clauses that contain lexical declarations (e.g. `let`, `const`, `function`, and `class`). eslint: [`no-case-declarations`](https://eslint.org/docs/rules/no-case-declarations.html)

    > Why? Lexical declarations are visible in the entire `switch` block but only get initialized when assigned, which only happens when its `case` is reached. This causes problems when multiple `case` clauses attempt to define the same thing.

    ```javascript
    // bad
    switch (foo) {
      case 1:
        let x = 1;
        break;
      case 2:
        const y = 2;
        break;
      case 3:
        function f() {
          // ...
        }
        break;
      default:
        class C {}
    }

    // good
    switch (foo) {
      case 1: {
        let x = 1;
        break;
      }
      case 2: {
        const y = 2;
        break;
      }
      case 3: {
        function f() {
          // ...
        }
        break;
      }
      case 4:
        bar();
        break;
      default: {
        class C {}
      }
    }
    ```
  <a name="comparison--nested-ternaries"></a><a name="15.6"></a>
  - [15.6](#comparison--nested-ternaries) Ternaries should not be nested and generally be single line expressions. eslint: [`no-nested-ternary`](https://eslint.org/docs/rules/no-nested-ternary.html)

    ```javascript
    // bad
    const foo = maybe1 > maybe2
      ? "bar"
      : value1 > value2 ? "baz" : null;

    // split into 2 separated ternary expressions
    const maybeNull = value1 > value2 ? 'baz' : null;

    // better
    const foo = maybe1 > maybe2
      ? 'bar'
      : maybeNull;

    // best
    const foo = maybe1 > maybe2 ? 'bar' : maybeNull;
    ```
  <a name="comparison--unneeded-ternary"></a><a name="15.7"></a>
  - [15.7](#comparison--unneeded-ternary) Avoid unneeded ternary statements. eslint: [`no-unneeded-ternary`](https://eslint.org/docs/rules/no-unneeded-ternary.html)

    ```javascript
    // bad
    const foo = a ? a : b;
    const bar = c ? true : false;
    const baz = c ? false : true;

    // good
    const foo = a || b;
    const bar = !!c;
    const baz = !c;
    ```
## Blocks
  <a name="blocks--braces"></a><a name="16.1"></a>
  - [16.1](#blocks--braces) Use braces with all multi-line blocks. eslint: [`nonblock-statement-body-position`](https://eslint.org/docs/rules/nonblock-statement-body-position)

    ```javascript
    // bad
    if (test)
      return false;

    // good
    if (test) return false;

    // good
    if (test) {
      return false;
    }

    // bad
    function foo() { return false; }

    // good
    function bar() {
      return false;
    }
    ```
  <a name="blocks--cuddled-elses"></a><a name="16.2"></a>
  - [16.2](#blocks--cuddled-elses) If you’re using multi-line blocks with `if` and `else`, put `else` on the same line as your `if` block’s closing brace. eslint: [`brace-style`](https://eslint.org/docs/rules/brace-style.html)

    ```javascript
    // bad
    if (test) {
      thing1();
      thing2();
    }
    else {
      thing3();
    }

    // good
    if (test) {
      thing1();
      thing2();
    } else {
      thing3();
    }
    ```
  <a name="blocks--no-else-return"></a><a name="16.3"></a>
  - [16.3](#blocks--no-else-return) If an `if` block always executes a `return` statement, the subsequent `else` block is unnecessary. A `return` in an `else if` block following an `if` block that contains a `return` can be separated into multiple `if` blocks. eslint: [`no-else-return`](https://eslint.org/docs/rules/no-else-return)

    ```javascript
    // bad
    function foo() {
      if (x) {
        return x;
      } else {
        return y;
      }
    }

    // bad
    function cats() {
      if (x) {
        return x;
      } else if (y) {
        return y;
      }
    }

    // bad
    function dogs() {
      if (x) {
        return x;
      } else {
        if (y) {
          return y;
        }
      }
    }

    // good
    function foo() {
      if (x) {
        return x;
      }

      return y;
    }

    // good
    function cats() {
      if (x) {
        return x;
      }

      if (y) {
        return y;
      }
    }

    // good
    function dogs(x) {
      if (x) {
        if (z) {
          return y;
        }
      } else {
        return z;
      }
    }
    ```
## Control Statements

  <a name="control-statements"></a>
  - [17.1](#control-statements) In case your control statement (`if`, `while` etc.) gets too long or exceeds the maximum line length, each (grouped) condition could be put into a new line. The logical operator should begin the line.

    > Why? Requiring operators at the beginning of the line keeps the operators aligned and follows a pattern similar to method chaining. This also improves readability by making it easier to visually follow complex logic.

    ```javascript
    // bad
    if ((foo === 123 || bar === 'abc') && doesItLookGoodWhenItBecomesThatLong() && isThisReallyHappening()) {
      thing1();
    }

    // bad
    if (foo === 123 &&
      bar === 'abc') {
      thing1();
    }

    // bad
    if (foo === 123
      && bar === 'abc') {
      thing1();
    }

    // bad
    if (
      foo === 123 &&
      bar === 'abc'
    ) {
      thing1();
    }

    // good
    if (
      foo === 123
      && bar === 'abc'
    ) {
      thing1();
    }

    // good
    if (
      (foo === 123 || bar === 'abc')
      && doesItLookGoodWhenItBecomesThatLong()
      && isThisReallyHappening()
    ) {
      thing1();
    }

    // good
    if (foo === 123 && bar === 'abc') {
      thing1();
    }
    ```

  <a name="control-statement--value-selection"></a><a name="control-statements--value-selection"></a>
  - [17.2](#control-statements--value-selection) Don't use selection operators in place of control statements.

    ```javascript
    // bad
    !isRunning && startRunning();

    // good
    if (!isRunning) {
      startRunning();
    }
    ```
## Comments

  <a name="comments--multiline"></a><a name="17.1"></a>
  - [18.1](#comments--multiline) Use `/** ... */` for multi-line comments.

    ```javascript
    // bad
    // make() returns a new element
    // based on the passed in tag name
    //
    // @param {String} tag
    // @return {Element} element
    function make(tag) {

      // ...

      return element;
    }

    // good
    /**
     * make() returns a new element
     * based on the passed-in tag name
     */
    function make(tag) {

      // ...

      return element;
    }
    ```

  <a name="comments--singleline"></a><a name="17.2"></a>
  - [18.2](#comments--singleline) Use `//` for single line comments. Place single line comments on a newline above the subject of the comment. Put an empty line before the comment unless it’s on the first line of a block.

    ```javascript
    // bad
    const active = true;  // is current tab

    // good
    // is current tab
    const active = true;

    // bad
    function getType() {
      console.log('fetching type...');
      // set the default type to 'no type'
      const type = this.type || 'no type';

      return type;
    }

    // good
    function getType() {
      console.log('fetching type...');

      // set the default type to 'no type'
      const type = this.type || 'no type';

      return type;
    }

    // also good
    function getType() {
      // set the default type to 'no type'
      const type = this.type || 'no type';

      return type;
    }
    ```

  <a name="comments--spaces"></a>
  - [18.3](#comments--spaces) Start all comments with a space to make it easier to read. eslint: [`spaced-comment`](https://eslint.org/docs/rules/spaced-comment)

    ```javascript
    // bad
    //is current tab
    const active = true;

    // good
    // is current tab
    const active = true;

    // bad
    /**
     *make() returns a new element
     *based on the passed-in tag name
     */
    function make(tag) {

      // ...

      return element;
    }

    // good
    /**
     * make() returns a new element
     * based on the passed-in tag name
     */
    function make(tag) {

      // ...

      return element;
    }
    ```

  <a name="comments--actionitems"></a><a name="17.3"></a>
  - [18.4](#comments--actionitems) Prefixing your comments with `FIXME` or `TODO` helps other developers quickly understand if you’re pointing out a problem that needs to be revisited, or if you’re suggesting a solution to the problem that needs to be implemented. These are different than regular comments because they are actionable. The actions are `FIXME: -- need to figure this out` or `TODO: -- need to implement`.

  <a name="comments--fixme"></a><a name="17.4"></a>
  - [18.5](#comments--fixme) Use `// FIXME:` to annotate problems.

    ```javascript
    class Calculator extends Abacus {
      constructor() {
        super();

        // FIXME: shouldn’t use a global here
        total = 0;
      }
    }
    ```

  <a name="comments--todo"></a><a name="17.5"></a>
  - [18.6](#comments--todo) Use `// TODO:` to annotate solutions to problems.

    ```javascript
    class Calculator extends Abacus {
      constructor() {
        super();

        // TODO: total should be configurable by an options param
        this.total = 0;
      }
    }
    ```
## Whitespace

  <a name="whitespace--spaces"></a><a name="18.1"></a>
  - [19.1](#whitespace--spaces) Use soft tabs (space character) set to 4 spaces. eslint: [`indent`](https://eslint.org/docs/rules/indent.html)

    ```javascript
    // bad
    function foo() {
    ∙∙∙∙let name;
    }

    // bad
    function bar() {
    ∙let name;
    }

    // good
    function baz() {
    ∙∙let name;
    }
    ```
  <a name="whitespace--before-blocks"></a><a name="18.2"></a>
  - [19.2](#whitespace--before-blocks) Place 1 space before the leading brace. eslint: [`space-before-blocks`](https://eslint.org/docs/rules/space-before-blocks.html)

    ```javascript
    // bad
    function test(){
      console.log('test');
    }

    // good
    function test() {
      console.log('test');
    }

    // bad
    dog.set('attr',{
      age: '1 year',
      breed: 'Bernese Mountain Dog',
    });

    // good
    dog.set('attr', {
      age: '1 year',
      breed: 'Bernese Mountain Dog',
    });
    ```
  <a name="whitespace--around-keywords"></a><a name="18.3"></a>
  - [19.3](#whitespace--around-keywords) Place 1 space before the opening parenthesis in control statements (`if`, `while` etc.). Place no space between the argument list and the function name in function calls and declarations. eslint: [`keyword-spacing`](https://eslint.org/docs/rules/keyword-spacing.html)

    ```javascript
    // bad
    if(isJedi) {
      fight ();
    }

    // good
    if (isJedi) {
      fight();
    }

    // bad
    function fight () {
      console.log ('Swooosh!');
    }

    // good
    function fight() {
      console.log('Swooosh!');
    }
    ```
  <a name="whitespace--infix-ops"></a><a name="18.4"></a>
  - [19.4](#whitespace--infix-ops) Set off operators with spaces. eslint: [`space-infix-ops`](https://eslint.org/docs/rules/space-infix-ops.html)

    ```javascript
    // bad
    const x=y+5;

    // good
    const x = y + 5;
    ```
  <a name="whitespace--chains"></a><a name="18.6"></a>
  - [19.6](#whitespace--chains) Use indentation when making long method chains (more than 2 method chains). Use a leading dot, which
    emphasizes that the line is a method call, not a new statement. eslint: [`newline-per-chained-call`](https://eslint.org/docs/rules/newline-per-chained-call) [`no-whitespace-before-property`](https://eslint.org/docs/rules/no-whitespace-before-property)

    ```javascript
    // bad
    $('#items').find('.selected').highlight().end().find('.open').updateCount();

    // bad
    $('#items').
      find('.selected').
        highlight().
        end().
      find('.open').
        updateCount();

    // good
    $('#items')
      .find('.selected')
        .highlight()
        .end()
      .find('.open')
        .updateCount();

    // bad
    const leds = stage.selectAll('.led').data(data).enter().append('svg:svg').classed('led', true)
        .attr('width', (radius + margin) * 2).append('svg:g')
        .attr('transform', `translate(${radius + margin},${radius + margin})`)
        .call(tron.led);

    // good
    const leds = stage.selectAll('.led')
        .data(data)
      .enter().append('svg:svg')
        .classed('led', true)
        .attr('width', (radius + margin) * 2)
      .append('svg:g')
        .attr('transform', `translate(${radius + margin},${radius + margin})`)
        .call(tron.led);

    // good
    const leds = stage.selectAll('.led').data(data);
    ```
  <a name="whitespace--after-blocks"></a><a name="18.7"></a>
  - [19.7](#whitespace--after-blocks) Leave a blank line after blocks and before the next statement.

    ```javascript
    // bad
    if (foo) {
      return bar;
    }
    return baz;

    // good
    if (foo) {
      return bar;
    }

    return baz;

    // bad
    const obj = {
      foo() {
      },
      bar() {
      },
    };
    return obj;

    // good
    const obj = {
      foo() {
      },

      bar() {
      },
    };

    return obj;

    // bad
    const arr = [
      function foo() {
      },
      function bar() {
      },
    ];
    return arr;

    // good
    const arr = [
      function foo() {
      },

      function bar() {
      },
    ];

    return arr;
    ```
  <a name="whitespace--padded-blocks"></a><a name="18.8"></a>
  - [19.8](#whitespace--padded-blocks) Do not pad your blocks with blank lines. eslint: [`padded-blocks`](https://eslint.org/docs/rules/padded-blocks.html)

    ```javascript
    // bad
    function bar() {

      console.log(foo);

    }

    // bad
    if (baz) {

      console.log(qux);
    } else {
      console.log(foo);

    }

    // bad
    class Foo {

      constructor(bar) {
        this.bar = bar;
      }
    }

    // good
    function bar() {
      console.log(foo);
    }

    // good
    if (baz) {
      console.log(qux);
    } else {
      console.log(foo);
    }
    ```
  <a name="whitespace--no-multiple-blanks"></a>
  - [19.9](#whitespace--no-multiple-blanks) Do not use multiple blank lines to pad your code. eslint: [`no-multiple-empty-lines`](https://eslint.org/docs/rules/no-multiple-empty-lines)

    <!-- markdownlint-disable MD012 -->
    ```javascript
    // bad
    class Person {
      constructor(fullName, email, birthday) {
        this.fullName = fullName;


        this.email = email;


        this.setAge(birthday);
      }


      setAge(birthday) {
        const today = new Date();


        const age = this.getAge(today, birthday);


        this.age = age;
      }


      getAge(today, birthday) {
        // ..
      }
    }

    // good
    class Person {
      constructor(fullName, email, birthday) {
        this.fullName = fullName;
        this.email = email;
        this.setAge(birthday);
      }

      setAge(birthday) {
        const today = new Date();
        const age = getAge(today, birthday);
        this.age = age;
      }

      getAge(today, birthday) {
        // ..
      }
    }
    ```
  <a name="whitespace--in-brackets"></a><a name="18.10"></a>
  - [19.11](#whitespace--in-brackets) Add spaces inside brackets. eslint: [`array-bracket-spacing`](https://eslint.org/docs/rules/array-bracket-spacing.html)

    ```javascript
    // bad
    const foo = [1, 2, 3];
    console.log(foo[0]);

    // good
    const foo = [ 1, 2, 3 ];
    console.log(foo[ 0 ]);
    ```

  <a name="whitespace--in-braces"></a><a name="18.11"></a>
  - [19.12](#whitespace--in-braces) Add spaces inside curly braces. eslint: [`object-curly-spacing`](https://eslint.org/docs/rules/object-curly-spacing.html)

    ```javascript
    // bad
    const foo = {clark: 'kent'};

    // good
    const foo = { clark: 'kent' };
    ```
  <a name="whitespace--max-len"></a><a name="18.12"></a>
  - [19.13](#whitespace--max-len) Avoid having lines of code that are longer than 100 characters (including whitespace). Note: per [above](#strings--line-length), long strings are exempt from this rule, and should not be broken up. eslint: [`max-len`](https://eslint.org/docs/rules/max-len.html)

    > Why? This ensures readability and maintainability.

    ```javascript
    // bad
    const foo = jsonData && jsonData.foo && jsonData.foo.bar && jsonData.foo.bar.baz && jsonData.foo.bar.baz.quux && jsonData.foo.bar.baz.quux.xyzzy;

    // bad
    $.ajax({ method: 'POST', url: 'https://airbnb.com/', data: { name: 'John' } }).done(() => console.log('Congratulations!')).fail(() => console.log('You have failed this city.'));

    // good
    const foo = jsonData
      && jsonData.foo
      && jsonData.foo.bar
      && jsonData.foo.bar.baz
      && jsonData.foo.bar.baz.quux
      && jsonData.foo.bar.baz.quux.xyzzy;

    // good
    $.ajax({
      method: 'POST',
      url: 'https://airbnb.com/',
      data: { name: 'John' },
    })
      .done(() => console.log('Congratulations!'))
      .fail(() => console.log('You have failed this city.'));
    ```
  <a name="whitespace--block-spacing"></a>
  - [19.14](#whitespace--block-spacing) Require consistent spacing inside an open block token and the next token on the same line. This rule also enforces consistent spacing inside a close block token and previous token on the same line. eslint: [`block-spacing`](https://eslint.org/docs/rules/block-spacing)

    ```javascript
    // bad
    function foo() {return true;}
    if (foo) { bar = 0;}

    // good
    function foo() { return true; }
    if (foo) { bar = 0; }
    ```

  <a name="whitespace--comma-spacing"></a>
  - [19.15](#whitespace--comma-spacing) Avoid spaces before commas and require a space after commas. eslint: [`comma-spacing`](https://eslint.org/docs/rules/comma-spacing)

    ```javascript
    // bad
    var foo = 1,bar = 2;
    var arr = [1 , 2];

    // good
    var foo = 1, bar = 2;
    var arr = [1, 2];
    ```
  <a name="whitespace--func-call-spacing"></a>
  - [19.17](#whitespace--func-call-spacing) Avoid spaces between functions and their invocations. eslint: [`func-call-spacing`](https://eslint.org/docs/rules/func-call-spacing)

    ```javascript
    // bad
    func ();

    func
    ();

    // good
    func();
    ```

  <a name="whitespace--key-spacing"></a>
  - [19.18](#whitespace--key-spacing) Enforce spacing between keys and values in object literal properties. eslint: [`key-spacing`](https://eslint.org/docs/rules/key-spacing)

    ```javascript
    // bad
    var obj = { "foo" : 42 };
    var obj2 = { "foo":42 };

    // good
    var obj = { "foo": 42 };
    ```
## Commas

  <a name="commas--leading-trailing"></a><a name="19.1"></a>
  - [20.1](#commas--leading-trailing) Leading commas: **Nope.** eslint: [`comma-style`](https://eslint.org/docs/rules/comma-style.html)

    ```javascript
    // bad
    const story = [
        once
      , upon
      , aTime
    ];

    // good
    const story = [
      once,
      upon,
      aTime,
    ];

    // bad
    const hero = {
        firstName: 'Ada'
      , lastName: 'Lovelace'
      , birthYear: 1815
      , superPower: 'computers'
    };

    // good
    const hero = {
      firstName: 'Ada',
      lastName: 'Lovelace',
      birthYear: 1815,
      superPower: 'computers',
    };
    ```
  <a name="commas--dangling"></a><a name="19.2"></a>
  - [20.2](#commas--dangling) Additional trailing comma: **Yup.** eslint: [`comma-dangle`](https://eslint.org/docs/rules/comma-dangle.html)

    > Why? This leads to cleaner git diffs. Also, transpilers like Babel will remove the additional trailing comma in the transpiled code which means you don’t have to worry about the [trailing comma problem](https://github.com/airbnb/javascript/blob/es5-deprecated/es5/README.md#commas) in legacy browsers.

    ```diff
    // bad - git diff without trailing comma
    const hero = {
         firstName: 'Florence',
    -    lastName: 'Nightingale'
    +    lastName: 'Nightingale',
    +    inventorOf: ['coxcomb chart', 'modern nursing']
    };

    // good - git diff with trailing comma
    const hero = {
         firstName: 'Florence',
         lastName: 'Nightingale',
    +    inventorOf: ['coxcomb chart', 'modern nursing'],
    };
    ```

    ```javascript
    // bad
    const hero = {
      firstName: 'Dana',
      lastName: 'Scully'
    };

    const heroes = [
      'Batman',
      'Superman'
    ];

    // good
    const hero = {
      firstName: 'Dana',
      lastName: 'Scully',
    };

    const heroes = [
      'Batman',
      'Superman',
    ];

    // bad
    function createHero(
      firstName,
      lastName,
      inventorOf
    ) {
      // does nothing
    }

    // good
    function createHero(
      firstName,
      lastName,
      inventorOf,
    ) {
      // does nothing
    }

    // good (note that a comma must not appear after a "rest" element)
    function createHero(
      firstName,
      lastName,
      inventorOf,
      ...heroArgs
    ) {
      // does nothing
    }

    // bad
    createHero(
      firstName,
      lastName,
      inventorOf
    );

    // good
    createHero(
      firstName,
      lastName,
      inventorOf,
    );

    // good (note that a comma must not appear after a "rest" element)
    createHero(
      firstName,
      lastName,
      inventorOf,
      ...heroArgs
    );
    ```
## Type Casting & Coercion
  <a name="coercion--explicit"></a><a name="21.1"></a>
  - [22.1](#coercion--explicit) Perform type coercion at the beginning of the statement.

  <a name="coercion--strings"></a><a name="21.2"></a>
  - [22.2](#coercion--strings) Strings: eslint: [`no-new-wrappers`](https://eslint.org/docs/rules/no-new-wrappers)

    ```javascript
    // => this.reviewScore = 9;

    // bad
    const totalScore = new String(this.reviewScore); // typeof totalScore is "object" not "string"

    // bad
    const totalScore = this.reviewScore + ''; // invokes this.reviewScore.valueOf()

    // bad
    const totalScore = this.reviewScore.toString(); // isn’t guaranteed to return a string

    // good
    const totalScore = String(this.reviewScore);
    ```

  <a name="coercion--numbers"></a><a name="21.3"></a>
  - [22.3](#coercion--numbers) Numbers: Use `Number` for type casting and `parseInt` always with a radix for parsing strings. eslint: [`radix`](https://eslint.org/docs/rules/radix) [`no-new-wrappers`](https://eslint.org/docs/rules/no-new-wrappers)

    ```javascript
    const inputValue = '4';

    // bad
    const val = new Number(inputValue);

    // bad
    const val = +inputValue;

    // bad
    const val = inputValue >> 0;

    // bad
    const val = parseInt(inputValue);

    // good
    const val = Number(inputValue);

    // good
    const val = parseInt(inputValue, 10);
    ```


  <a name="coercion--booleans"></a><a name="21.6"></a>
  - [22.6](#coercion--booleans) Booleans: eslint: [`no-new-wrappers`](https://eslint.org/docs/rules/no-new-wrappers)

    ```javascript
    const age = 0;

    // bad
    const hasAge = new Boolean(age);

    // good
    const hasAge = Boolean(age);

    // best
    const hasAge = !!age;
    ```
## Naming Conventions
  <a name="naming--descriptive"></a><a name="22.1"></a>
  - [23.1](#naming--descriptive) Avoid single letter names. Be descriptive with your naming. eslint: [`id-length`](https://eslint.org/docs/rules/id-length)

    ```javascript
    // bad
    function q() {
      // ...
    }

    // good
    function query() {
      // ...
    }
    ```

  <a name="naming--camelCase"></a><a name="22.2"></a>
  - [23.2](#naming--camelCase) Use camelCase when naming objects, functions, and instances. eslint: [`camelcase`](https://eslint.org/docs/rules/camelcase.html)

    ```javascript
    // bad
    const OBJEcttsssss = {};
    const this_is_my_object = {};
    function c() {}

    // good
    const thisIsMyObject = {};
    function thisIsMyFunction() {}
    ```

  <a name="naming--PascalCase"></a><a name="22.3"></a>
  - [23.3](#naming--PascalCase) Use PascalCase only when naming constructors or classes. eslint: [`new-cap`](https://eslint.org/docs/rules/new-cap.html)

    ```javascript
    // bad
    function user(options) {
      this.name = options.name;
    }

    const bad = new user({
      name: 'nope',
    });

    // good
    class User {
      constructor(options) {
        this.name = options.name;
      }
    }

    const good = new User({
      name: 'yup',
    });
    ```
  <a name="naming--filename-matches-export"></a><a name="22.6"></a>
  - [23.6](#naming--filename-matches-export) A base filename should exactly match the name of its default export.

    ```javascript
    // file 1 contents
    class CheckBox {
      // ...
    }
    export default CheckBox;

    // file 2 contents
    export default function fortyTwo() { return 42; }

    // file 3 contents
    export default function insideDirectory() {}

    // in some other file
    // bad
    import CheckBox from './checkBox'; // PascalCase import/export, camelCase filename
    import FortyTwo from './FortyTwo'; // PascalCase import/filename, camelCase export
    import InsideDirectory from './InsideDirectory'; // PascalCase import/filename, camelCase export

    // bad
    import CheckBox from './check_box'; // PascalCase import/export, snake_case filename
    import forty_two from './forty_two'; // snake_case import/filename, camelCase export
    import inside_directory from './inside_directory'; // snake_case import, camelCase export
    import index from './inside_directory/index'; // requiring the index file explicitly
    import insideDirectory from './insideDirectory/index'; // requiring the index file explicitly

    // good
    import CheckBox from './CheckBox'; // PascalCase export/import/filename
    import fortyTwo from './fortyTwo'; // camelCase export/import/filename
    import insideDirectory from './insideDirectory'; // camelCase export/import/directory name/implicit "index"
    // ^ supports both insideDirectory.js and insideDirectory/index.js
    ```

  <a name="naming--camelCase-default-export"></a><a name="22.7"></a>
  - [23.7](#naming--camelCase-default-export) Use camelCase when you export-default a function. Your filename should be identical to your function’s name.

    ```javascript
    function makeStyleGuide() {
      // ...
    }

    export default makeStyleGuide;
    ```
  <a name="naming--Acronyms-and-Initialisms"></a>
  - [23.9](#naming--Acronyms-and-Initialisms) Acronyms and initialisms should always be all uppercased, or all lowercased.

    > Why? Names are for readability, not to appease a computer algorithm.

    ```javascript
    // bad
    import SmsContainer from './containers/SmsContainer';

    // bad
    const HttpRequests = [
      // ...
    ];

    // good
    import SMSContainer from './containers/SMSContainer';

    // good
    const HTTPRequests = [
      // ...
    ];

    // also good
    const httpRequests = [
      // ...
    ];

    // best
    import TextMessageContainer from './containers/TextMessageContainer';

    // best
    const requests = [
      // ...
    ];
    ```
  <a name="naming--uppercase"></a>
  - [23.10](#naming--uppercase) You may optionally uppercase a constant only if it (1) is exported, (2) is a `const` (it can not be reassigned), and (3) the programmer can trust it (and its nested properties) to never change.

    > Why? This is an additional tool to assist in situations where the programmer would be unsure if a variable might ever change. UPPERCASE_VARIABLES are letting the programmer know that they can trust the variable (and its properties) not to change.
    - What about all `const` variables? - This is unnecessary, so uppercasing should not be used for constants within a file. It should be used for exported constants however.
    - What about exported objects? - Uppercase at the top level of export (e.g. `EXPORTED_OBJECT.key`) and maintain that all nested properties do not change.

    ```javascript
    // bad
    const PRIVATE_VARIABLE = 'should not be unnecessarily uppercased within a file';

    // bad
    export const THING_TO_BE_CHANGED = 'should obviously not be uppercased';

    // bad
    export let REASSIGNABLE_VARIABLE = 'do not use let with uppercase variables';

    // ---

    // allowed but does not supply semantic value
    export const apiKey = 'SOMEKEY';

    // better in most cases
    export const API_KEY = 'SOMEKEY';

    // ---

    // bad - unnecessarily uppercases key while adding no semantic value
    export const MAPPING = {
      KEY: 'value'
    };

    // good
    export const MAPPING = {
      key: 'value'
    };
    ```
## Accessors

  <a name="accessors--no-getters-setters"></a><a name="23.2"></a>
  - [24.2](#accessors--no-getters-setters) Do not use JavaScript getters/setters as they cause unexpected side effects and are harder to test, maintain, and reason about. Instead, if you do make accessor functions, use `getVal()` and `setVal('hello')`.

    ```javascript
    // bad
    class Dragon {
      get age() {
        // ...
      }

      set age(value) {
        // ...
      }
    }

    // good
    class Dragon {
      getAge() {
        // ...
      }

      setAge(value) {
        // ...
      }
    }
    ```
  <a name="accessors--boolean-prefix"></a><a name="23.3"></a>
  - [24.3](#accessors--boolean-prefix) If the property/method is a `boolean`, use `isVal()` or `hasVal()`.

    ```javascript
    // bad
    if (!dragon.age()) {
      return false;
    }

    // good
    if (!dragon.hasAge()) {
      return false;
    }
    ```

























