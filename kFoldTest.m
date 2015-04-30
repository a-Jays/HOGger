function [Acc] = kFoldTest( Data, Params )

	% performs k(=4)-fold cross-validation.
	% Data is split into 4 parts; 3 parts are used to train and one to test.
	% The 4 accuracies obtained are averaged then, into `Acc`.
	% The 4 folds are trained in parallel, beware. Uses 4 logical cores.
	
	% This function is a moronic proxy for getAccuracy which actually does the work.
	% It could very well be written inside SVMTrainTest.
	% Please fix!
	
	getAccuracy1 = @(D) getAccuracy( D, Params );
	Results = parcellfun( 4, getAccuracy1, Data );
	Acc = mean( Results );

endfunction
