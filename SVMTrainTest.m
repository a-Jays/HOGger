function [SVMModel] = SVMTrainTest( posData, negData, kernel )

	% function to perform SVM training and testing using the `kernel` kernel
	% and return the best model obtained from grid search.
	% have some coffee.
	
	fprintf("Starting grid search with 4-fold cross-validation.\nGet some coffee meanwhile..\n");
	Degree_init = 3;
	Gamma_init = 10;
	
	if strcmp( kernel, "linear" )
		Gamma_init = 10;
		Type = 0;
	else
		Gamma_init = 0.0001;
		Type = 2;
		if strcmp( kernel, "poly2" )
			Degree_init = 2;
			Type = 1;
		endif
	endif
	
	optC = C = 0.001;
	optGamma = Gamma = Gamma_init;
	optDegree = Degree = Degree_init;
	MaxAcc = 0;
	
	TrainData = [ negData; posData ];
	Labels = [ -ones( size(negData,1),1 ); ones( size(posData,1),1 ) ];
	parts = cvpartition( Labels, "KFold", 4 );

	for cn = 1:4
		Data{1,cn} = [ Labels( training(parts,cn) ) TrainData( training(parts,cn),: ); Labels( test(parts,cn) ) TrainData( test(parts,cn),: ) ];
	endfor
	
	while Degree <= 3
		C = 0.001;
		while C < 10
			Gamma = Gamma_init;
			while Gamma <= 10
				Param = ['-q -h 1 -t ', num2str(Type), ' -c ', num2str(C), ' -g ', num2str(Gamma), ' -d ', num2str(Degree)];
				Acc = kFoldTest( Data, Param );
				if Acc > MaxAcc
					MaxAcc = Acc;
					optC = C;
					optGamma = Gamma;
					optDegree = Degree;
				endif
				Gamma *= 2;
			endwhile
			C *= 2;
		endwhile
		Degree += 1;
	endwhile
	
	% once training done, use best parameters to obtain the "best model".
	
	Param = ['-q -h 1 -t ', num2str(Type), ' -c ', num2str(optC), ' -g ', num2str(optGamma), ' -d ', num2str(optDegree)];
	fprintf( "Grid search done.\nBest Accuracy (CV): %f\nTraining with: %s\n", MaxAcc, Param );
	fflush( stdout );
	SVMModel = svmtrain( Labels, [negData; posData], Param );
	
endfunction
