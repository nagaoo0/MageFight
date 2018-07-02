x+=(o_proto_fighter_v2.x-x)/4
y+=(o_proto_fighter_v2.y-y)/4
if point_distance(x,x,o_proto_fighter_v2.x,o_proto_fighter_v2.x)<2{
	instance_destroy(self)
	with(o_proto_fighter_v2) draw=true;
	}