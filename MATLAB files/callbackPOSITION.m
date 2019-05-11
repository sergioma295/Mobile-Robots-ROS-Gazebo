function callbackPOSITION(msg,p)

global x
global y

x = round(p.Pose.Pose.Position.X);
y = round(p.Pose.Pose.Position.Y);

end

