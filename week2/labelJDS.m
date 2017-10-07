function labelJDS( xy )
%labelJDS Numbers the points of an n-pointed star

tips = xy(:,1:2:end);

for i = 1:(length(tips(1,:)) -1)
    text(tips(1,i),tips(2,i),int2str(i))
end

end

