function [hog] = HOGger( img, NBins, CSize, BlockSize )

	% base function to compute HOG, named as a pun on its CPU hogging nature :)
	% CSize is n, for a cell of nxn pixels. Default is 8.
	% BlockSize is n, for a block of nxn cells. Default is 2.
	
	if nargin < 4
		NBins = 9;
		if nargin < 3
			CSize = 8;
			if nargin < 2
				BlockSize = 2;
			end
		end
	end
	
	if ndims( img ) == 3
		img = rgb2gray( img );
	end
	[imagn, iangle] = imgradient( img );
	imagm( imagn==0 ) = 0.001;
	iangle( iangle<0 ) = iangle( iangle<0 ) + 180;
	iangle( iangle == 0 ) = 1;
	
	% --------- create cells and get their histograms.
	
	cell_hists = zeros( size(img,1)/CSize, size(img,2)/CSize, NBins );	% 16x8x9: 16x8 with a 9-bin histogram.
	%size( cell_hists )
	%cell_hists(1,1,:)
	p = q = 1;
	CSize = 8;
	
	[img_h, img_w]=size(img);
	for i=1:CSize:img_h
		q = 1;
		for j=1:CSize:img_w
			cell_hists(p,q,:) = weighted_histogram( imagn(i:i+CSize-1, j:j+CSize-1), iangle(i:i+CSize-1, j:j+CSize-1), 9,180 );
			q = q+1;
		end
		p = p+1; 
	end
	
	%size( cell_hists )
	% --------- group cells into blocks and normalise them
	tic;
	for dd = 1:1000

	%hog = zeros( BlockSize*CSize*NBins, 1 );
	%fprintf('%0.2f ', cell_hists(1,1,:)); fprintf('\n');
	hog = [];
	p = 1;	q = 36;
	for i=1:size(cell_hists,1)-1
		for j=1:size(cell_hists,2)-1
			%hog = [ hog; block_normalise( cell_hists( i:i+1, j:j+1, : ) ) ];
			temp = cell_hists( i:i+BlockSize-1, j:j+BlockSize-1, : ) ;
			temp = temp(:);
			%s = 1/sum(temp(:));
			%hog(p:q,1) = temp(:)/sum(temp(:));
			%hog(p:q,1) = block_normalise( cell_hists( i:i+1, j:j+1, : ) );
			%p = q+1;
			%q = q+36;
			hog = [hog; temp/sum(temp)];
		end
	end
	end;
	hog2 = [];
	B = reshape( cell_hists, [16*8 9] );
	for ii = 1:16
		temp = [ B(:,ii); B(:,ii+1); B(:,ii+16); B(:,ii+16+1) ];
		temp = temp(:);
		hog2 = [hog2; temp/sum(temp)];
	end
	toc
	%size(hog)
end
