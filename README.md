# natural-sort
When sorting filenames gives you this order:

 - pict1.jpg
 - pict10.jpg
 - pict100.jpg
 - pict2.jpg

you might consider natural sorting.
Natural sorting is about considering the numeric value of group(s) of digits in a string instead of considering the digits as single characters. This way the filenames above are sorted this way:

 - pict1.jpg
 - pict2.jpg
 - pict10.jpg
 - pict100.jpg

Which feels more natural... Doesn't it?

## Getting started

Download the demo project at https://github.com/zaatardigital/natural-sort and open the project in Xojo's IDE. Select the 'NaturalSortLib' module, then copy & paste it into your project. You can close the demo project and save your own project.

## Using NaturalSortLib

### Preamble

`NaturalSortLib` doesn't do the actual sorting. Instead it tells you which precedes the other **in ascending order**. If you want to compare the `foo` and `bar` strings, you just have to call the `NaturalSortLib.Compare()` protected function like this:
```
Dim theResult As Integer = NaturalSort.Compare( foo, bar )
```
 - If `theResult` is 0, `foo` and `bar` are equals on a **natural** basis and it's up to you to decide.
 - If `theResult` is -1, `foo` < `bar`.
 - If `theResult` is 1, `foo` > `bar`.
 
 ### Example
 
`NaturalSortLib.Compare()` is very easy to use in `ListBox.CompareRows()` event. As easy as this:
```
Function CompareRows(row1 as Integer, row2 as Integer, column as Integer, ByRef result as Integer ) As Boolean

  result = NaturalSortLib.Compare( Me.Cell( row1, column ), Me.Cell( Row2,Column ) )
  Return True

End Function

```
See http://developer.xojo.com/listbox for more information about `ListBox`.

## Notes
**To perform the natural comparison, strings are being splitted in differents parts either numerical or text parts. To speed up the splitting when a particular string is compared multiple times which is part of all sorting process, the split result is cached in a `Dictionary`. To avoid having too much memory used by this cache, you should consider calling `NaturalSortLib.ClearNaturalSplitCache()` each time a sort operation is complete.**

Take a look at the source code and its comments to get more details about the implementation of the "natural" split and the caching.

If you find a bug or have a feature request feel free go to the project's GitHub page at https://github.com/zaatardigital/natural-sort.

© Eric de La Rochette / June 2017
