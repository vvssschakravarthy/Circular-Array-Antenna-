% Extract the SLL, BW and Nulls
% Feb 2019
% Theta in DEGREES
% Signal Info should be 0 if no steering

function [slll, sllr, thL, thR, fnbw, af_nullr, af_nulll] = SBN(afdvals,sign_info,thdeg)


% Size of the AF matrix
[r c]=size(afdvals);
% Theta in degrees
th=thdeg;

% -----Find first nulls ---------------------------------------------------
mb=sign_info; % Main Beam location
mbindx=find(th==mb); 
thlen=length(th);

for afr=1:r
%     RIGHT NULLS 
    af_nullr=[];nullr_indx=[];
    afd=afdvals(afr,:);
    i=mbindx;
    while i<=thlen-2
        if( afd(i)>afd(i+1)&& afd(i+2)>afd(i+1) )
            af_nullr=afd(i+1);  % right null depth
            nullr_indx=i+1;     % right null index
            i=thlen;
        else
            i=i+1;
        end
    end

    if(isempty(af_nullr)) % if there are no nulls
       af_nullr=afd(end);
       nullr_indx=thlen;
    end

    %     LEFT NULLS
    af_nulll=[];nulll_indx=[];
    clear i;
    i=mbindx;
    while i>2
        if( afd(i)>afd(i-1)&& afd(i-2)>afd(i-1) )
            af_nulll=afd(i-1);  % right null depth
            nulll_indx=i-1;     % right null index
            i=1;
        else
            i=i-1;
        end
    end   

    if(isempty(af_nulll)) % if there are no nulls
       af_nulll=afd(1);
       nulll_indx=1;
    end
    fnbw(afr)=th(nullr_indx)-th(nulll_indx);
    thR(afr)=th(nullr_indx);
    thL(afr)=th(nulll_indx);
    %    END of Find First NULLS-----------------------------------------------

    %  FIND SLL BEGINS ********************************************************

    sllr(afr)=max(afd(nullr_indx:end));
    slll(afr)=max(afd(1:nulll_indx));

%  END OF FIND SLL ********************************************************

end
end

