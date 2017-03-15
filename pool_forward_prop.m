function [feat_maps] = pool_forward_prop(pool_in,layer_ind)
[inp_d1, inp_d2, inp_nos]=size(pool_in);
feat_maps=zeros(inp_d1/2,inp_d2/2,inp_nos);
s=inp_d1;
for m=1:inp_nos
    j=1;
    current_FM=pool_in(:,:,m);
    out_FM=zeros(inp_d1/2,inp_d2/2);
    i=1;
    while i<=((s*s)-s-1)
        if (mod(i+1,s)==0)&&(mod(((i+1)/s),2)~=0)
            out_FM(j)=max(current_FM([i,i+1,i+s,i+s+1]));            
            i=i+s+2;
            j=j+1;
            
        else
            out_FM(j)=max(current_FM([i,i+1,i+s,i+s+1]));
            j=j+1;
            i=i+2;
        end
    end
    feat_maps(:,:,m)=ReLU(out_FM);
end
end
% current_FM=pool_in(:,:,i);
%     out_FM=zeros(inp_d1/2,inp_d2/2);
%     for j=1:2:inp_d1-1
%         for k=1:2:inp_d2-1
%             res=max(max(current_FM(j:j+1,k:k+1)));
%             out_FM((j+1)/2,(k+1)/2)=res;
%         end
%     end
%     feat_maps(:,:,i)=ReLU(out_FM);
