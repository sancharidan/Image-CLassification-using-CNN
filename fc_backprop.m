function [ grad_prev, delta_current ] = fc_backprop( current, del_prev, weights )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
grad_prev=current'*del_prev;
for i=1:18
    delta_current(i)=sum(weights(i,:).*del_prev);
end
end

