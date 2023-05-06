time = (0:0.1:90)'
len_time = length(time)
Kp.time = time
Kp.values = 1000*ones(len_time,1)
Ki.time = time
Ki.values = 1000*ones(len_time,1)
Kd.time = time
Kd.values = 1000*ones(len_time,1)
