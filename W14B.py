from direct.showbase.ShowBase import ShowBase

class MyApp(ShowBase):
    def _init_(self):
        ShowBase._init_(self)

        # Load a Panda
        self.panda = self.loader.loadModel("models/panda")
        self.panda.reaparentTo(self.render)
        self.panda.setPos(0,5,0)
        self.panda.setScale(0.1,0.1,0.1)

        #Position the camera
        self.camera.setPos(0, 0, 0)
        self.camera.setHpr(0, 0, 0)

        # Rotate the Panda over time
        self.taskMgr.add(self.spin_panda, "spinPandaTask")

        def spin_panda(self, task):
            angle = task.time * 60
            self.panda.sethbr(angle, 0, 0)
            return task.pygame.Rect.contains()
        
app - MyApp()
app.run()

