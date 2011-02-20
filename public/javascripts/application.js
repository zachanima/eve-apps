// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

function addCommas(input) {
  output = input.toString();
  var sRegExp = new RegExp('(-?[0-9]+)([0-9]{3})');
  while(sRegExp.test(output)) {
    output = output.replace(sRegExp, '$1,$2');
  }
  return output;
}
