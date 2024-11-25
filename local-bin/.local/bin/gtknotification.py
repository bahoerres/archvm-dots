from gi.repository import GObject
from gi import require_version

require_version('Notify', '0.7')

from gi.repository import Notify

class GTKNotification(GObject.Object):
    def __init__(self):
        super(GTKNotification, self).__init__()
        # lets initialise with the application name
        Notify.init("Pomodoro Timer")

    def send_notification(self, title, text, file_path_to_icon=""):
        n = Notify.Notification.new(title, text, file_path_to_icon)
        n.show()
