function [Acc] = getAccuracy( A, Params )

  % A is one cell that contains `ndata` [label, vector] pairs.
  % First 3/4th are training.. because, well, `cvpartition`.
  % Attempt to make this, or kFoldTest, an inline function.
  
	ndata = size(A,1);
	svm1 = svmtrain( A(1:3*ndata/4, 1), A(1:3*ndata/4, 2:end), Params );
	[~, acc, ~] = svmpredict( A(1+3*ndata/4:end, 1), A(1+3*ndata/4:end, 2:end), svm1 );
	Acc = acc(1);
	
endfunction

