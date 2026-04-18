# Libopc

*Libopc* is a C library for processing [ISO/IEC 29500‑2](https://www.iso.org/standard/77818.html) (Open Packaging Conventions) files.
It was originally developed by [Florian Reuter](https://github.com/freuter).

The OPC file format is natively supported in the Windows SDK starting with Windows 7, via the [Packaging](https://learn.microsoft.com/en-us/previous-versions/windows/desktop/opc/packaging?redirectedfrom=MSDN) API.
*Libopc* aims to provide a free, non‑Windows solution for manipulating such files in C and C++ applications.

**Note:** *Libopc* focuses on packaging files and managing relationship parts.
For example, inserting an image requires setting up relationships and adding the image into the package.
It does **not** support editing the actual document data (e.g., PNG, JPEG, etc.).
For that, we recommend using your own library/tool, as mentioned in [issue #3](https://github.com/freuter/libopc/issues/3).

---

## Documentation

[WIP]

---

## License

*Libopc* is distributed under the terms of the [BSD‑3‑Clause](https://github.com/wissem01chiha/libopc/blob/master/LICENSE).

---

## Downloads

Version `libopc‑1.0.0` is not yet released.
Use Git to get the latest updates from the master branch:

```bash
git clone --depth 1 https://github.com/wissem01chiha/libopc
```

---

## Contributions

The project is under maintenance. Adding new features may not be the main target at the moment.
However, contributions are highly encouraged — check the To‑Do [list]().If you are interested in collaborating, feel free to open an [issue](https://github.com/wissem01chiha/libopc/issues), I will try to address any concerns as best I can.
