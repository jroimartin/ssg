# ssg - simple slide generator

## Description

ssg is a slide generation system which provides a markdown-like syntax.

## Usage

`cat slides | ssg > slides.ps`

See t/test for typical use cases.

## Customization

Copy doc/config to your working directory and customize it. Then, load the
new config with:

`cat slides | ssg -c config > slides.ps`

## Encoding

`ssg < slides | iconv -f UTF-8 -t L1 > slides.ps`

## Author

* Nibble \<develsec.org\>
