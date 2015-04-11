function [hst] = weighted_histogram( grad_mags, grad_angles, NBins, HLimit )

	% for a cell.
	% computes N-bin histogram, specifically for HOGging purposes :)
	
	% [grad_mag, grad_angle] = imgradient( img );		-- bad idea!
	
	if nargin < 4
		HLimit = 180;
		if nargin < 3
			NBins = 9;
		end
	end
		
	
	hst = zeros( NBins, 1 );
	
	%grad_angles = ceil( grad_angles(:)*(NBins/HLimit) );
	[~,grad_angles] = histc(grad_angles(:),[0:ceil(180/NBins):180]);
	grad_mags = grad_mags(:);
	%for x = 1:length( grad_angles )
	%	hst(grad_angles(x)) = hst(grad_angles(x)) + grad_mags(x);
	%end
	
	for i = 1:max(grad_angles)
		 hst(i)=sum(grad_mags(grad_angles==i));
	end
	
	%size(hst)
	% if you want to see what the histogram of each cell looks like.
	% fprintf('%0.2f ', hst'); fprintf('\n');
	% hst'			 
end
