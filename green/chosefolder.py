#!/usr/bin/env python3
import wx
from pathlib import Path
import os
import fileinput


class main_window(wx.Frame):
    def __init__(self, *args, **kwds):
        # begin wxGlade: main_window.__init__
        kwds["style"] = kwds.get("style", 0) | wx.DEFAULT_FRAME_STYLE
        wx.Frame.__init__(self, *args, **kwds)
        self.SetSize((517, 130))
        self.text_ctrl_1 = wx.TextCtrl(self, wx.ID_ANY, "", style = wx.TE_READONLY)
        self.button_2 = wx.Button(self, wx.ID_ANY, "Chose Folder")
        self.button_3 = wx.Button(self, wx.ID_ANY, "Save Changes")

        self.__set_properties()
        self.__do_layout()

        self.Bind(wx.EVT_BUTTON, self.chose_folder, self.button_2)
        self.Bind(wx.EVT_BUTTON, self.save_changes, self.button_3)
        # end wxGlade

    def __set_properties(self):
        # begin wxGlade: main_window.__set_properties
        self.SetTitle("GRD Tethering Menu")
        # end wxGlade

    def __do_layout(self):
        # begin wxGlade: main_window.__do_layout
        sizer_3 = wx.BoxSizer(wx.VERTICAL)
        sizer_4 = wx.BoxSizer(wx.HORIZONTAL)
        sizer_4.Add(self.text_ctrl_1, 1, wx.ALL, 3)
        sizer_4.Add(self.button_2, 0, wx.ALL, 3)
        sizer_3.Add(sizer_4, 1, wx.ALL | wx.EXPAND, 6)
        sizer_3.Add(self.button_3, 0, wx.ALIGN_CENTER_HORIZONTAL | wx.ALL, 8)
        self.SetSizer(sizer_3)
        self.Layout()
        # end wxGlade

    def chose_folder(self, event):  # wxGlade: main_window.<event_handler>
        dlg = wx.DirDialog (None, "Choose save directory", "", wx.DD_DEFAULT_STYLE)
        dlg.ShowModal()
        dir=""
        if dlg.GetPath() == "":
            dir=str(Path.home())
        else:
            dir=dlg.GetPath()
        self.text_ctrl_1.SetValue(dir)

    def save_changes(self, event):  # wxGlade: main_window.<event_handler>
        dir=self.text_ctrl_1.GetValue()
        if dir == "":
            dlg = wx.MessageDialog(None, "Error, please select a valid folder", "Missing folder")
            dlg.ShowModal()

        else:
            print ("Success")
            search_for='store_photos_in'
            newvalue=search_for + '="' + dir + '"'


            filedownloadall=os.path.join(Path.home(), "Desktop","Applications", "downloadall.sh")
            with fileinput.FileInput(filedownloadall, inplace=True, backup='.bak') as file:
                exit=0
                for line in file:
                    if search_for in line and exit==0:
                        line = newvalue
                        #print(line.replace(search_for, newvalue), end='')
                        exit=1
                        print (line.strip())
                    else:
                        print (line.strip())
            filedownloadall=os.path.join(Path.home(), "Desktop","Applications", "capture-tethered-wifi.sh")

            with fileinput.FileInput(filedownloadall, inplace=True, backup='.bak') as file:
                exit=0
                for line in file:
                    if search_for in line and exit==0:
                        line = newvalue
                        #print(line.replace(search_for, newvalue), end='')
                        exit=1
                        print (line.strip())
                    else:
                        print (line.strip())

            filed_tethering=os.path.join(Path.home(), "Desktop","Applications", "downloadall-wifi.sh")

            with fileinput.FileInput(filedownloadall, inplace=True, backup='.bak') as file:
                exit=0
                for line in file:
                    if search_for in line and exit==0:
                        line = newvalue
                        #print(line.replace(search_for, newvalue), end='')
                        exit=1
                        print (line.strip())
                    else:
                        print (line.strip())

            filed_tethering=os.path.join(Path.home(), "Desktop","Applications", "capture-tethered.sh")

            with fileinput.FileInput(filed_tethering, inplace=True, backup='.bak') as file:
                exit=0
                for line in file:
                    if search_for in line and exit==0:
                        line = newvalue
                        #print(line.replace(search_for, newvalue), end='')
                        exit=1
                        print (line.strip())
                    else:
                        print (line.strip())
            dlg = wx.MessageDialog(None, "All saves changes", "Sucess")
            dlg.ShowModal()

        event.Skip()

# end of class main_window

class MyApp(wx.App):
    def OnInit(self):
        self.frame = main_window(None, wx.ID_ANY, "")
        self.SetTopWindow(self.frame)
        self.frame.Show()
        return True

# end of class MyApp

if __name__ == "__main__":
    app = MyApp(0)
    app.MainLoop()
