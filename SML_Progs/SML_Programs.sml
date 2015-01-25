(*1. Rotate list *)
(*To delete the rotated element from the end*)
fun delete([n], []) = [] | delete([n], l) = if n=hd(l) then tl(l) else hd(l)::delete([n], tl(l));

(*Length of list*)
fun length [] = 0 | length(x::t) = 1+ length(t);
(*To find last element*)
fun last [] = nil |  last([x]) = [x] |  last(x::t) = last(t);

fun rotate ([], n) = [] | rotate(l,0) = l | rotate(h::t,n) = if(length(h::t)<n) then rotate (h::t, n mod (length(h::t))) else rotate(last(h::t)@delete(last(h::t), h::t), n-1);
(*Example*)
rotate([1,2,3,4,5],4);


(*2. Matrix multiplication *)

(*For multiplication*)
fun multiply (a,b) = a*b;
(*For product of two lists*)
fun product(l: int list,m:int list) = if(null(l)) then 0 else if (null(m)) then 0 else multiply(hd(l),hd(m))+product(tl(l),tl(m));
(*To generate the row for output*)
fun producerow(x,y) = if(null(x)) then nil else if (null(y)) then nil else product(x,hd(y))::producerow(x,tl(y));
(*Recursive function for multiplication*)
fun matmul1(l:int list list, m:int list list) = if(null(l)) then nil else if(null(m)) then nil else producerow(hd(l),m)::matmul1(tl(l),m);
(*For calculating transpose of the matrix*)
fun transpose [] = []
| transpose ([]::_) = []
| transpose mat = (map hd mat)::(transpose(map tl mat));

fun matmul (a:int list list, b:int list list) = matmul1(a,transpose(b));
(*Example*)
matmul ( [[1,0,0],[0,1,0],[0,0,1]], [[1,2,3],[4,5,6],[7,8,9]]);


(*3. Tower of Hanoi*)
(*Recursive function for Tower of Hanoi problem*)
fun hanoi (0,a,b,c) = [] |
hanoi(1,a,b,c)= [(a,b)]|
hanoi(n,a,b,c) = (hanoi(n-1,a,c,b))@((a,b)::(hanoi(n-1,c,b,a)));
(*Example*)
hanoi(3, 1, 3, 2);


(*4. Mileage per gallons *)
(*For calculating total mileage*)
fun total_mileage([]) = 0 |
total_mileage(x::y:(int*real)list) = #1(x) + total_mileage(y);
(*For calculating total gallons*)
fun total_gallons([]) = 0.0 |
total_gallons(x::y:(int*real)list) = #2(x) + total_gallons(y);

fun mpg ([]) = (0,0.0,0.0) |
mpg(l:(int*real)list)= (total_mileage(l),total_gallons(l), real(total_mileage(l)) / total_gallons(l));
(*Example*)
mpg( [(2,3.0),(5,4.0),(10,10.0)] );


(*5. Set operations *)

(* Union *)

fun member(n, l) = if null(l) then false else if hd(l)=n then true
else member(n, tl(l));

fun delete(n, []) = [] 
| delete(n, l) = if (n=hd(l)) then tl(l) 
  else hd(l)::delete(n, tl(l));

fun union(l, m) = if(null(l)) then m
else if (null(m)) then l
else if member(hd(l), m) then union(l, delete(hd(l), m))
else hd(l)::union(tl(l), m);

(* Intersection *)
fun intersection(l, m)=if(null(l)) then []
else if (null(m)) then []
else if member(hd(l), m) then hd(l)::intersection(tl(l), m)
else intersection(tl(l), m);

(* Setdiff *)
fun setdiff(l, m)=if(null(l)) then m
else if member(hd(l), m) then setdiff(l,delete(hd(l),m))
else hd(l)::setdiff(tl(l),m);

(* Subset *)
fun subset(l, m)=if(null(l)) then true
else if(null(m)) then false
else if member(hd(l), m) then subset(tl(l), m)
else false;

(* Powerset *)
fun merge(a,b) = if(null(b)) then []
 else union([a],hd(b))::merge(a,tl(b));
fun powerset(l) = if (null(l)) then [[]] 
else union(powerset(tl(l)), merge(hd(l), powerset(tl(l))));


(*6. Quicksort *)
(*For finding pivot*)
fun pivot(l,v,p) = if(null(l)) then 0 
else if(null(tl(l))) then p
else if (abs(v - hd(l)) <= abs(v - p)) then pivot(tl(l), v, hd(l))
		else pivot(tl(l), v, p);	
(*For sum of all elements*)
fun sum ([]) = 0 |
sum (x::t) = x+ sum(t);
(*Length of list*)
fun length ([]) = 0 | length(x::t) = 1+ length(t);
(*Average for the elements*)
fun avg ([]) = 0 |
avg([x]) = x |
avg(l) = sum(l) div length(l);
(*For finding elements greater than pivot*)		
fun greater([],p) = [] |
greater([h],p) =  if(h> p) then [h] else [] |
greater(l,p) = if(hd(l)> p) then (hd(l)::greater(tl(l),p)) else greater(tl(l),p);
(*For finding elements smaller than pivot*)
fun smaller([],p) = [] |
smaller([h],p) =  if(h < p) then [h] else [] |
smaller(l,p) = if(hd(l) < p) then hd(l)::smaller(tl(l),p) else smaller(tl(l),p);

fun qsort(nil) = nil |
	qsort([h]) = [h] |
	qsort(l) = 
	let val av = avg(l)
		val piv = pivot(l, av, 0)
		val left = smaller(l, piv)
		val right = greater(l, piv)
	in qsort(left) @ (piv::qsort(right))
	end;
(*Example*)	
qsort([8,5,2,9,1,7,3,6,4]);


(*7. Bubble sort*)
(*For comparison*)
fun compare(nil, n) = nil |
	compare(l, 1) = nil |
	compare([h], n) = [h] |
	compare(first::second::t, n) = if first>second then second::(compare(first::t, n-1))
		else first::(compare(second::t, n-1)); 
(*For length of list*)
fun length [] = 0 | length(x::t) = 1+ length(t);
(*For finding the last element of the list*)
fun last([]) = nil |
  last([h]) = [h] |
	last(h::t) = last(t);
(*To fetch the first elements*)
fun returnstartingelements(h::t, x) = if(null(h::t)) then nil
  else if(x=0) then nil
  else if(x=1) then [h] 
	else if x > length(h::t) then h::t
		else h::returnstartingelements(t, x - 1);

(*Recursive function for bubble sort*)
fun bsort(h::t, m, n) = if(m=0) andalso(n=0) then nil 
  else if (null(t)) then [h]
  else if (n=0) then bsort(compare(h::t, length(h::t) + 1), m, 1) 
  else if (m =n) then compare(h::t, length(h::t)+1)@last(t)
		else bsort( compare( returnstartingelements(h::t, length(t)), length(h::t)), m, n+1)@last(t);

fun bubblesort(nil) = nil |
	bubblesort([h]) = [h] |
	bubblesort(l) = bsort(l, length(l)+1, 0);
(*Example*)
bubblesort [7,1,3,9,2,5,4,6,8];



(*8. Reverse, Sum, Fibonacci *)

(*Reverse*)
fun lreverse([], p) = p |
lreverse(x::t, p)=lreverse(t,x::p);

fun reverse(l) = lreverse(l, []);
(*Example*)
reverse([4,3,2,1]);

(*Sum*)
fun listsum([], p) = p |
listsum(x::t, p) = listsum(t, x+p);

fun sum(l)=listsum(l, 0);
(*Example*)
sum([2,3,4]);

(*Fibonacci*)
fun accfib(0, b, i, j, x) = 0|
  accfib(1, b, i, j, x) = 1 |
	accfib(a, b, i, j, x) = if (a = b) then x
	else if b > a then ~1
	else accfib(a, b+1, i+j, i, i+j);

fun fibonacci(0) = 0 |
	fibonacci(1) = 1 |
	fibonacci(n) = accfib(n, 2, 1, 1, 1);
(*Example*)
fibonacci(3);
