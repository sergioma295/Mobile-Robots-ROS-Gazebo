function [oc] = freePath(o,option)
  global map
  oc = 0;
  
  it = 0;
  
  if option == 1
      while it <= 1
          x = o.x-it;
          if getOccupancy(map,[x,o.y]) == 1

              oc = 1;
              break;
          end

          it = it + 0.01;
      end
  elseif option == 2
       while it <= 1
          x = o.x+it;
          if getOccupancy(map,[x,o.y]) == 1

              oc = 1;
              break;
          end

          it = it + 0.01;
       end
  elseif option == 3

       while it <= 1
          y = o.y+it;
          if getOccupancy(map,[o.x,y]) == 1

              oc = 1;
              break;
          end

          it = it + 0.01;
       end
       
  else

       while it <= 1
          y = o.y-it;
          if getOccupancy(map,[o.x,y]) == 1

              oc = 1;
              break;
          end

          it = it + 0.01;
       end
  end

end

