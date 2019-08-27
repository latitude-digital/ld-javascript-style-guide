module.exports = {
	"parser": "babel-eslint",
	"extends": [
		"eslint:recommended",
        "plugin:import/errors",
        "plugin:import/warnings",
	],
	"parserOptions": {
		"ecmaVersion": 8,
		"sourceType": "module",
		"ecmaFeatures": {
			"jsx": true,
            "arrowFunctions": true,
			"experimentalObjectRestSpread": true,
		}
	},
	"globals": {
		"__DEV__": false,
		"Promise": true,
		"PKG_VERSION": true,
		"APP_VERSION": true,
		"BUGSNAG_KEY": true,
	},
	"plugins": [
		"react",
		"import",
	],
	"settings": {
		"import/resolver": {
			"node": {
				"paths": [
					"src"
				]
			}
		},
		"react": {
			"createClass": "createClass",
			"pragma": "React",
			"version": "16.2"
		}
	},
	"env": {
		"browser": true,
		"node": true,
		"commonjs": true,
		"es6": true
	},
	"rules": {
		"no-console": "off",
		"no-useless-escape": "off",
		"no-empty-pattern": "off",

		"import/first": "error",



		/* Spacing */
        "arrow-spacing": "error",
        "space-before-blocks": "error",
        "block-spacing": "error",
        "func-call-spacing": ["error", "never"],
        "spaced-comment": ["error", "always"],

        "key-spacing": ["error", {
        	"afterColon": true,
        	"mode": "strict",
		}],
        "keyword-spacing": ["error", {
        	"after": true,
		}],
        "array-bracket-spacing": ["error", "always", {
        	"objectsInArrays": false,
		}],
        "object-curly-spacing": ["error", "always"],
        "template-curly-spacing": ["error", "never"],
        "comma-spacing": ["error", {
        	"before": false,
			"after": true,
		}],
        "space-in-parens": ["error", "never"],
        "space-infix-ops": "error",
        "no-whitespace-before-property": "error",
        "newline-per-chained-call": ["error", {
        	"ignoreChainWithDepth": 2,
		}],
        "padded-blocks": ["error", "never"],
        "no-multiple-empty-lines": "error",
        "indent": ["warn", 2, {
        	"SwitchCase": 1,
        }],
        "max-len": ["error", {
        	"code": 80,
			"tabWidth": 2,
            "ignoreUrls": true,
            "ignoreStrings": true,
            "ignoreTemplateLiterals": true,
            "ignoreRegExpLiterals": true
		}],


		/* Commas */
        "comma-style": ["error", "last"],
        "comma-dangle": [ "warn", {
            "arrays": "always-multiline",
            "objects": "always-multiline",
            "imports": "always-multiline",
            "exports": "never",
            "functions": "ignore"
        }],
        "semi": ["error", "always"],

        "no-else-return": "error",
        "no-nested-ternary": "error",
        "no-case-declarations": "error",


		/* Variables */
        "no-var": "error",
        "prefer-const": "error",
		"one-var": ["error", "never"],
        "no-unused-vars": ["warn", { "ignoreModules": true }],


		/* Naming */
        "id-length": ["error", {
            "min": 4,
        	"exceptions": [ "x", "o" ],
		}],
        "camelcase": ["error", {
        	"properties": "never",
            "allow": ["^UNSAFE_"],
            "ignoreDestructuring": true,
        }],
        "no-underscore-dangle": ["error", {
            "allowAfterThis": true,
        }],


        "no-new-wrappers": "error",
        "eqeqeq": ["error", "smart"],
        "object-shorthand": "error",
        "prefer-spread": "error",
        "prefer-template": "error",
        "no-duplicate-imports": "error",
        "prefer-arrow-callback": "error",
        "implicit-arrow-linebreak": ["error", "beside"],
        "no-param-reassign": "error",
        "prefer-destructuring": ["error", {
            "array": true,
            "object": true
        }, {
            "enforceForRenamedProperties": false
        }],



		"quotes": ["warn", "single", {
			"avoidEscape": true,
			"allowTemplateLiterals": true
		}],


		"react/jsx-uses-react": "error",
		"react/jsx-uses-vars": "error",
		"react/no-array-index-key": "warn",
	}
};
