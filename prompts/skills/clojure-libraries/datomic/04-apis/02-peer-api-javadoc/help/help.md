<a id="javadoc-help"></a>

# JavaDoc Help

- [Navigation](#help-navigation):
  - [Search](#search)
- [Kinds of Pages](#help-pages):
  - [Package](#package)
  - [Class or Interface](#class)
  - [Other Files](#doc-file)
  - [Tree (Class Hierarchy)](#tree)
  - [All Packages](#all-packages)
  - [All Classes and Interfaces](#all-classes)
  - [Index](#index)

------------------------------------------------------------------------

<a id="help-navigation"></a>

## Navigation

Starting from the [Overview](../documentation-home/documentation-home.md) page, you can browse the documentation using the links in each page, and in the navigation bar at the top of each page. The [Index](../index/index.md) and Search box allow you to navigate to specific declarations and summary pages, including: [All Packages](../all-packages/all-packages.md), [All Classes and Interfaces](../all-classes-and-interfaces/all-classes-and-interfaces.md)
<a id="search"></a>

### Search

You can search for definitions of modules, packages, types, fields, methods, system properties and other terms defined in the API. These items can be searched using part or all of the name, optionally using "camelCase" abbreviations, or multiple search terms separated by whitespace. Some examples:

- `"j.l.obj"` matches "java.lang.Object"
- `"InpStr"` matches "java.io.InputStream"
- `"math exact long"` matches "java.lang.Math.absExact(long)"

Refer to the [Javadoc Search Specification](https://docs.oracle.com/en/java/javase/21/docs/specs/javadoc/javadoc-search-spec.html) for a full description of search features.

------------------------------------------------------------------------

<a id="help-pages"></a>

## Kinds of Pages

The following sections describe the different kinds of pages in this collection.
<a id="package"></a>

### Package

Each package has a page that contains a list of its classes and interfaces, with a summary for each. These pages may contain the following categories:

- Interfaces
- Classes
- Enum Classes
- Exception Classes
- Annotation Interfaces

<a id="class"></a>

<a id="class-or-interface"></a>

### Class or Interface

Each class, interface, nested class and nested interface has its own separate page. Each of these pages has three sections consisting of a declaration and description, member summary tables, and detailed member descriptions. Entries in each of these sections are omitted if they are empty or not applicable.

- Class Inheritance Diagram
- Direct Subclasses
- All Known Subinterfaces
- All Known Implementing Classes
- Class or Interface Declaration
- Class or Interface Description

  

- Nested Class Summary
- Enum Constant Summary
- Field Summary
- Property Summary
- Constructor Summary
- Method Summary
- Required Element Summary
- Optional Element Summary

  

- Enum Constant Details
- Field Details
- Property Details
- Constructor Details
- Method Details
- Element Details

Note: Annotation interfaces have required and optional elements, but not methods. Only enum classes have enum constants. The components of a record class are displayed as part of the declaration of the record class. Properties are a feature of JavaFX.

The summary entries are alphabetical, while the detailed descriptions are in the order they appear in the source code. This preserves the logical groupings established by the programmer.

<a id="doc-file"></a>

<a id="other-files"></a>

### Other Files

Packages and modules may contain pages with additional information related to the declarations nearby.

<a id="tree"></a>

<a id="tree-class-hierarchy"></a>

### Tree (Class Hierarchy)

There is a [Class Hierarchy](../all-package-hierarchy/all-package-hierarchy.md) page for all packages, plus a hierarchy for each package. Each hierarchy page contains a list of classes and a list of interfaces. Classes are organized by inheritance structure starting with `java.lang.Object`. Interfaces do not inherit from `java.lang.Object`.

- When viewing the Overview page, clicking on TREE displays the hierarchy for all packages.
- When viewing a particular package, class or interface page, clicking on TREE displays the hierarchy for only that package.

<a id="all-packages"></a>

### All Packages

The [All Packages](../all-packages/all-packages.md) page contains an alphabetic index of all packages contained in the documentation.

<a id="all-classes"></a>

<a id="all-classes-and-interfaces"></a>

### All Classes and Interfaces

The [All Classes and Interfaces](../all-classes-and-interfaces/all-classes-and-interfaces.md) page contains an alphabetic index of all classes and interfaces contained in the documentation, including annotation interfaces, enum classes, and record classes.

<a id="index"></a>

### Index

The [Index](../index/index.md) contains an alphabetic index of all classes, interfaces, constructors, methods, and fields in the documentation, as well as summary pages such as [All Packages](../all-packages/all-packages.md), [All Classes and Interfaces](../all-classes-and-interfaces/all-classes-and-interfaces.md).

------------------------------------------------------------------------

This help file applies to API documentation generated by the standard doclet.
