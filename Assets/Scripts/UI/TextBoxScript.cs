using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class TextBoxScript : MonoBehaviour
{
    private static TextBoxScript Instance;
    [SerializeField] private InputField inputField;

    private void Start()
    {
        Instance = this;
        Instance.inputField.onEndEdit.AddListener(ProcessMessage);
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.T))
        {
            Instance.inputField.ActivateInputField();
            PlayerManager.movementAllowed = false;
            PlayerManager.lookingAroundAllowed = false;
            PlayerManager.shootingAllowed = false;
            PlayerManager.reloadingAllowed = false;
        }
        else if (Input.GetKeyDown(KeyCode.Escape))
        {
            Instance.inputField.DeactivateInputField();
        }
    }

    public static void ProcessMessage(string message)
    {
        if (message.Length > 0)
        {
            Instance.inputField.text = ""; //clearing the text box

            if (message[0] == '/')
            {
                //this message was indeed a command since '/' was the first character
                string[] splitCommand = message.Substring(1).Split(' ');

                if (splitCommand.Length == 3)
                {
                    if (splitCommand[0] == "give")
                    {
                        switch (splitCommand[1])
                        {
                            case "cash":
                                if (int.TryParse(splitCommand[2], out int amount))
                                {
                                    PlayerManager.GiveMoney(amount);
                                }

                                break;
                            case "weapon":
                                switch (splitCommand[2].ToLower())
                                {
                                    case "ak47":
                                        GameManager.Instance.SpawnGun(Gun.GunType.AK47);
                                        break;
                                    case "m4a1":
                                        GameManager.Instance.SpawnGun(Gun.GunType.M4A1);
                                        break;
                                    case "shotgun":
                                        GameManager.Instance.SpawnGun(Gun.GunType.Shotgun);
                                        break;
                                    case "pistol":
                                        GameManager.Instance.SpawnGun(Gun.GunType.Pistol);
                                        break;
                                }

                                break;
                        }
                    }
                    else if (splitCommand[0] == "set")
                    {
                        switch (splitCommand[1])
                        {
                            case "round":
                                if (int.TryParse(splitCommand[2], out int round))
                                {
                                    PlayerStats.roundsSurvived = round;
                                }

                                break;
                        }
                    }
                }
            }
        }

        PlayerManager.movementAllowed = true;
        PlayerManager.lookingAroundAllowed = true;
        PlayerManager.shootingAllowed = true;
        PlayerManager.reloadingAllowed = true;
    }
}
