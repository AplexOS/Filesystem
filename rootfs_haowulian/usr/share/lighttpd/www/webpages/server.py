#!/usr/bin/python3

from websocket_server import WebsocketServer
import os;
import can;
import time

DO_num = 0;

# python-can-socket
can.rc['interface'] = 'socketcan_native'
can.rc['channel'] = 'can0'
can.rc['bitrate'] = 1000000
from can.interfaces.interface import Bus

# python-can set-up
def can_setup(can_name):
    can_setup_command = "canconfig " + can_name + " bitrate 1000000 restart-ms 1000 ctrlmode triple-sampling on";
    can_start_command = "canconfig " + can_name + " start";
    can.rc['channel'] = can_name;
    pass;
    os.system(can_setup_command);
    os.system(can_start_command);

# python-can stop
def can_stop(can_name):
    can_stop_command = "canconfig " + can_name + " stop";
    os.system(can_stop_command);

# python-can send msg
def can_send_msg(ctl_id, ctl_data):
    bus = can.interface.Bus();
    msg = can.Message(arbitration_id = ctl_id,
            data=[ctl_data, 0, 0, 0, 0, 0, 0, 0],
            extended_id = False);
    try:
        bus.send(msg);
    except can.CanError:
        print("Message NOT sent");

# python-can recv msg
def can_recv_msg():
    bus = can.interface.Bus();
    try:
        msg = bus.recv(100);
        return msg;
    except can.CanError:
        print("Message NOT rese");
        return None ;

# websocket
# Called for every client connecting (after handshake)
def new_client(client, server):
    print("New client connected and was given id %d" % client['id']);
    print("DO_num : %d" % DO_num);
    server.send_message_to_all(str(DO_num));  # send DO_num to clinet to init it

# Called for every client disconnecting
def client_left(client, server):
    print("Client(%d) disconnected" % client['id'])

# Called when a client sends a message
def message_received(client, server, message):
    global DO_num;
    DO_num = int(message);
    ctl_id = DO_num >> 8;
    ctl_data = DO_num & 0xff;
    can_send_msg(ctl_id, ctl_data);     # send to can_client to ctrl it
    #print("ctl_id : %d    ctl_data : %d" % (ctl_id, ctl_data));
    if ((ctl_id >> 7) == 1):
        recv_di_data = 0;
        msg = can_recv_msg();
        if (msg):
            recv_di_data = msg.data[0] | (msg.arbitration_id << 8);
            server.send_message_to_all(str(recv_di_data));  # send DI_num to client to display it
        else:
            print("recv errno");
    elif ((ctl_id >> 7) == 2):
        server.send_message_to_all(str(DO_num));   # send DO_num to client to save it

# init can
can_setup("can0");

PORT=9001
server = WebsocketServer(PORT, "0.0.0.0")
server.set_fn_new_client(new_client)
server.set_fn_client_left(client_left)
server.set_fn_message_received(message_received)
server.run_forever()
