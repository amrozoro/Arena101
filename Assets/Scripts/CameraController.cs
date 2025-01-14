using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour
{
    [SerializeField] Camera mainCam, thirdPersonCam;
    private static KeyCode switchView = KeyCode.F2;
    public static Camera currentActiveCam
    {
        get;
        private set;
    }

    void Start()
    {
        EnableCam(mainCam);
        DisableCam(thirdPersonCam);
        currentActiveCam = mainCam;
    }

    void Update()
    {
        if (Input.GetKeyDown(switchView))
        {
            //ToggleCam(mainCam);
            ToggleCam(thirdPersonCam);
            currentActiveCam = currentActiveCam == mainCam ? thirdPersonCam : mainCam;
        }
    }

    private void EnableCam(Camera cam)
    {
        cam.enabled = true;
    }

    private void DisableCam(Camera cam)
    {
        cam.enabled = false;
    }

    private void ToggleCam(Camera cam)
    {
        cam.enabled = !cam.enabled;
        //cam.targetDisplay = cam.targetDisplay == 1 ? 2 : 1;
    }
}
