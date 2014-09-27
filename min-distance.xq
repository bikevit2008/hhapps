(: 1. Минимальное расстояние
Дан набор из N точек на плоскости (для простоты можно считать, что у всех точек целочисленные координаты). Найдите минимальное расстояние между двумя точками из этого набора.

Пример входных данных:
10 10
20 10
20 15

Пример выходных данных:
5 :)
xquery version '3.0';
declare function local:distance($x1, $y1, $x2, $y2){
let $x-distance := $x1 - $x2
let $y-distance := $y1 - $y2
let $distance := math:sqrt(($x-distance * $x-distance) + ($y-distance * $y-distance))
return
$distance
};
declare function local:dots-distance($input){
let $tokenize := tokenize($input, '
')
let $count := count($tokenize)
let $circle := for $j in 1 to $count return for $i in 1 to $count  return 
if($j >= $i) then() else(
let $x1 := xs:double(substring-before(subsequence($tokenize, $j, 1), ' '))
let $y1 := xs:double(substring-after(subsequence($tokenize, $j, 1), ' '))
let $x2 := xs:double(substring-before(subsequence($tokenize, $i, 1), ' '))
let $y2 := xs:double(substring-after(subsequence($tokenize, $i, 1), ' '))
return local:distance($x1, $y1, $x2, $y2))
return
if ($count <= 1) then('') else("Минимальное расстояние: " || xs:string(min($circle)))
};
let $request := request:get-parameter('numbers', '')
let $result := local:dots-distance($request)
return
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>Минимальное расстояние</title>
<link rel="stylesheet" href="bootstrap.css"/>
</head>
<body>
<div class="navbar-wrapper">
      <div class="container">

        <div class="navbar navbar-default navbar-static-top" role="navigation">
          <div class="container">
            <div class="navbar-header">
              <a class="navbar-brand">Минимальное расстояние</a>
            </div>
          </div>
        </div>
      </div>
    </div>
<div class="container">
<form>
<textarea class="form-control" name="numbers" rows="10" placeholder="10 10
20 10
20 15"/><br/>
<input type="submit" class="btn btn-success"/>
</form>
<h1>{$result}</h1>
</div>
</body></html>