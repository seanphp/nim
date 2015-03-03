# tup.nim
import math

type 
  Item = tuple[n: int, idx: int]
  Items = seq[Item]
  
proc insertSort[T](a: var openarray[T]) =
  for i in 1 .. < a.len:
    let value = a[i].n
    var j = i
    while j > 0 and (value < a[j-1].n):
      a[j] = a[j-1]
      dec j
    a[j] = a[i] 
    
    
proc shellSort[T](a: var openarray[T]) =
  var h = a.len
  while h > 0:
    h = h div 2
    for i in h .. < a.len:
      let k = a[i]
      var j = i
      while j >= h and k < a[j-h]:
        a[j] = a[j-h]
        j -= h
      a[j] = k    
    
proc shellSortIdxB(a: var openarray[int]): seq[int] =
  var h = a.len
  var r: seq[int] = @[]
  r.setLen(h)
  for i in 0 .. < a.len: r[i] = i
  while h > 0:
    h = h div 2
    for i in h .. < a.len:
      let k = a[i]
      let ka = a[i]
      let kb = r[i]
      var j = i
      while j >= h and k < a[j-h]:
        a[j] = a[j-h]
        r[j] = r[j-h]
        j -= h
      a[j] = ka
      r[j] = kb
  result = r
  
proc shellSortIdx(a: var openArray[int]; 
                  cmp: proc (x, y: int): int {.closure.}): seq[int] =
  var h = a.len
  result = @[]
  result.setLen(h)
  for i in 0 .. < a.len: result[i] = i
  while h > 0:
    h = h div 2
    for i in h .. < a.len:
      let k = a[result[i]]
      let ka = result[i]
      var j = i
      while j >= h and cmp(k, a[result[j-h]]) < 0:
#      while j >= h and a[result[j-h]] < k:
        result[j] = result[j-h]
        j -= h
      result[j] = ka
  
  
proc showIdx[T](a: var openArray[T]; b: openArray[int]): string =      
  result = ""
  for i in 0 .. < b.len:
    if i == 0:
      result = "@[" & $a[b[i]]
    else:
      result = result & ", " & $a[b[i]]
  result = result & "]"

when isMainModule:
  var rs: Items = @[]
  var r: Item = (100, 0)
  rs.add(r)
  r = (200, 1)
  rs.add(r)
  r = (300, 2)
  rs.add(r)
  echo rs
  swap(rs[0], rs[2])
  echo rs
  
  echo "\n10 items"
  randomize()
  rs.setLen(10)
  for i in 0 .. 9:
    rs[i].n = random(100)
    rs[i].idx = i
  echo rs
#  echo "Sorted"
#  insertSort(rs)
#  echo rs
  
  
  var a = @[4, 65, 3, -31, 0, 99, 2, 83, 782, -66]
#  shellSort(a)
#  echo a
  
  echo a
  var b = shellSortIdx(a, proc(x, y: int): int = result = x - y)
  echo "Shell sort asc index" 
  echo b
  echo showIdx(a, b)
  
  b = shellSortIdx(a, proc(x, y: int): int = result = y - x)
  echo "Shell sort desc index" 
  echo b
  echo showIdx(a, b)  

  