function layout() {
  return {
    name: "Centered",
    extends: "middle-wide",
    getFrameAssignments: (windows, screenFrame, state, extendedFrames) => {
      console.log('Switched to Centered layout')
      const screenWidth = screenFrame.width
      const halfSize = Math.round(screenWidth / 2) 
      const maxWidth = Math.floor(halfSize * 0.99)
      const hasOneWindow = windows.length === 1
      const oneWindowXOffset = Math.round((screenWidth - maxWidth) / 2)

      return extendedFrames.reduce((frames, extendedFrame) => {
        let x
        let width

        if (hasOneWindow) {
          x = oneWindowXOffset
          width = maxWidth
        } else {
          x = extendedFrame.frame.x
          width = extendedFrame.frame.width
        }

        const frame = {
          x,
          y: extendedFrame.frame.y,
          width,
          height: extendedFrame.frame.height,
        };
        
        return { ...frames, [extendedFrame.id]: frame };
      }, {});
    },
  };
}
