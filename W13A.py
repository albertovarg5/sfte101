from direct.showbase.ShowBase import ShowBase

class MyApp(ShowBase):
    def __init__(self):
        ShowBase.__init__(self)

        # Load a Panda
        self.panda = self.loader.loadModel("models/panda")
        self.panda.reparentTo(self.render)
        self.panda.setPos(0,5,0)
        self.panda.setScale(0.1,0.1,0.1)

        #Position the camera
        self.camera.setPos(0, 0, 0)
        self.camera.setHpr(0, 0, 0)

        # Rotate the Panda over time
        self.taskMgr.add(self.spin_panda, "spinPandaTask")

    def spin_panda(self, task):
        angle = task.time * 60
        self.panda.setHpr(angle, 180, 180)
        return task.cont
        
app = MyApp()
app.run()

