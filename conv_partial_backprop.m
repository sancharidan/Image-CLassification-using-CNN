function [ grad_prev, delta_current ] = conv_partial_backprop( del_prev, current, filter )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
[del_w, del_h, del_fms]=size(del_prev);
[filt_w, filt_h, filt_nos]=size(filter);
[curr_w,curr_h,curr_fms]=size(current);
grad_prev=zeros(size(filter));
delta_current=zeros(size(current));
current_flip=rot90(current,2);
for i=1:filt_nos
    res1=conv2(current_flip(:,:,i),del_prev(:,:,2*i-1),'valid');%get this from only those values on which prev layer is dependent
    res2=conv2(current_flip(:,:,i+1),del_prev(:,:,2*i),'valid');
    grad_prev(:,:,i)=res1+res2;
end
filt_flip=rot90(filter,2);
for i=1:curr_fms
    if i==1
        delta_current(:,:,i)=conv2(del_prev(:,:,i),filt_flip(:,:,i));
    elseif i==curr_fms
        delta_current(:,:,i)=conv2(del_prev(:,:,2*(i-1)),filt_flip(:,:,i-1));
    else
        res1=conv2(filt_flip(:,:,i-1),del_prev(:,:,2*(i-1)));
        res2=conv2(filt_flip(:,:,i),del_prev(:,:,2*i-1));
        delta_current(:,:,i)=res1+res2;
    end   
end
end
