using Microsoft.AspNet.SignalR;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB
{
    public class ProgressHub : Hub
    {
        public string msg = "0%";
        public int count = 0;

        public void SendMessage(string msg, int percent)
        {
            var message = msg + "...";
            var hubContext = GlobalHost.ConnectionManager.GetHubContext<ProgressHub>();
            hubContext.Clients.All.sendMessage(msg, percent);
        }

        public void GetCountAndMessage()
        {
            Clients.Caller.sendMessage(string.Format(msg), count);
        }
    }
}