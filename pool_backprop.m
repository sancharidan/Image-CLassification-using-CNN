function [ del_current ] = pool_backprop( del_prev, current, prev_pool )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
interm_delta=del_prev;%stores the intermediate delta values for the ReLU-ed part
del_current=zeros(size(current));
[pool1, pool2, pool3]=size(prev_pool);
for k=1:pool3
    for i=1:pool1
        for j=1:pool2
            if prev_pool(i,j,k)==0
                interm_delta(i,j,k)=0;
            end
        end
    end
end

[c1,c2,c3]=size(current);
for i=1:c3%runs over all feature maps
    for j=1:2:c1-1
        for k=1:2:c2-1
            submat=current(j:j+1,k:k+1,i);
            maxele=max(max(submat));
            for l=j:j+1
                for m=k:k+1
                    if current(l,m,i)==maxele
                        del_current(l,m,i)=interm_delta((j+1)/2,(k+1)/2,i);
                    else
                        del_current(l,m,i)=0;
                    end
                end
            end
        end
    end
end           
end

