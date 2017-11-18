function labelJDS( xy )
%labelJDS Numbers the points of an n-pointed star

for i = 1:(length(xy(1,:)) -1)
    text(xy(1,i),xy(2,i),int2str(i))
end

end

