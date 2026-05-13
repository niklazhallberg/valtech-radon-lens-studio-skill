# Custom TypeScript Configuration

## Overview[​**](#overview "Copy to clipboard")

The **tsconfig.json** file is a configuration file in a TypeScript project that instructs the TypeScript compiler on how to compile the project. It specifies which files to include and provides various settings that control the compilation process.

Lens Studio allows you to customize the **compilerOptions** in **tsconfig.json**. The **compilerOptions** section contains various settings that affect TypeScript compilation.

Lens Studio provides a template to extend the **tsconfig.json**:

![](/img/lens-studio/scripting/tsconfig-custom.png)

#### Generated tsconfig.json[​**](#generated-tsconfigjson "Copy to clipboard")

```
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es2019",
    "isolatedModules": true,
    "noEmit": true,
    "skipDefaultLibCheck": true,
    "experimentalDecorators": true,
    "allowJs": true,
    "lib": ["es2019"],
    "types": [],
    "paths": {
      "*": [
        "../Packages",
        "../Cache/TypeScript/Src/Assets/*",
        "../Cache/TypeScript/Src/Packages/*"
      ]
    }
  },
  "exclude": ["node_modules/typescript/lib/lib.dom.d.ts"],
  "include": [
    "../Cache/TypeScript/lib/LensifyTS/Declarations/**/*.d.ts",
    "../Assets/**/*.ts",
    "../Packages/**/*.ts",
    "../Cache/TypeScript/Src/**/*.ts"
  ]
}
```

This file must be placed in the root directory of your Asset Browser. None of the settings in the template **tsconfig.json** should be modified; they should only be extended. Review the avaliable list of [compiler options](#compiler-options) that can be modified to customize your TypeScript compilation process.

If the file is renamed or moved outside of the root directory of the Asset Browser, it will no longer have any effect, and the TypeScript compiler will fall back to the default configuration file.

## Compiler Options[​**](#compiler-options "Copy to clipboard")

Below is a structured list of configurations available for the compilerOptions in JSON format:

* `allowUnreachableCode`
* `allowUnusedLabels`
* `alwaysStrict`
* `exactOptionalPropertyTypes`
* `noFallthroughCasesInSwitch`
* `noImplicitAny`
* `noImplicitOverride`
* `noImplicitReturns`
* `noImplicitThis`
* `noPropertyAccessFromIndexSignature`
* `noUncheckedIndexedAccess`
* `noUnusedLocals`
* `noUnusedParameters`
* `strict`
* `strictBindCallApply`
* `strictBuiltinIteratorReturn`
* `strictFunctionTypes`
* `strictNullChecks`
* `strictPropertyInitialization`
* `useUnknownInCatchVariables`

#### tsconfig.json Example[​**](#tsconfigjson-example "Copy to clipboard")

```
{
  "compilerOptions": {
    "module": "commonjs",
    "target": "es2019",
    "isolatedModules": true,
    "noEmit": true,
    "skipDefaultLibCheck": true,
    "experimentalDecorators": true,
    "allowJs": true,
    "lib": ["es2019"],
    "types": [],
    "paths": {
      "*": [
        "../Packages",
        "../Cache/TypeScript/Src/Assets/*",
        "../Cache/TypeScript/Src/Packages/*"
      ]
    },
    "strict": true,
    "strictBindCallApply": false
  },
  "exclude": ["node_modules/typescript/lib/lib.dom.d.ts"],
  "include": [
    "../Cache/TypeScript/lib/LensifyTS/Declarations/**/*.d.ts",
    "../Assets/**/*.ts",
    "../Packages/**/*.ts",
    "../Cache/TypeScript/Src/**/*.ts"
  ]
}
```

Comments are not supported in `tsconfig.json` at this time.
