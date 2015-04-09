fprintf('bismillah!\n')

for fn = 1:924
	PersonCell{1,fn} = rgb2gray(imread( strcat( 'pedestrians128x64/per', sprintf('%05d',fn), '.ppm' ) ));
end

tic;
PersonHOG = parcellfun( nproc-1, @HOGger, PersonCell, 'UniformOutput', false );
toc;
disp('Positive class size:'), disp( size(PersonHOG) );

negFolder = dir('INRIAPerson/train_64x128_H96/neg/*png');

for fn = 1:size(negFolder,1)
	NonPersonCell{1,fn} = rgb2gray( imread( strcat('INRIAPerson/train_64x128_H96/neg/', negFolder(fn).name) ) );
end

%extractRegularPatch = @(img) img(50:50+127, 200:200+63);

tic;
NonPersonCell = parcellfun( nproc-1, @(img) img(50:50+127, 200:200+63), NonPersonCell, 'UniformOutput', false );
NonPersonHOG = parcellfun( nproc-1, @HOGger, NonPersonCell, 'UniformOutput', false );
toc;
disp('Negative class size:'), disp( size(NonPersonHOG) );
