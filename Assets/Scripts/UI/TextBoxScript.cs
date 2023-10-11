using System;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using System.IO;

public class TextBoxScript : MonoBehaviour
{
    private static TextBoxScript Instance;
    public static bool inputFieldActive = false;
    [SerializeField] private InputField inputField;

    private static List<string> commandHistory = new List<string>();

    private static int commandHistoryIndex = -1;
    private static int CommandHistoryIndex
    {
        get { return commandHistoryIndex; }
        set
        {
            if (value >= 0 && value < commandHistory.Count)
            {
                commandHistoryIndex = value;
            }
        }
    }

    private void Start()
    {
        Instance = this;
        inputField.onEndEdit.AddListener(ProcessMessage);
    }

    private void Update()
    {
        if (Input.GetKeyDown(KeyCode.T))
        {
            Instance.inputField.ActivateInputField();
            inputFieldActive = true;
            PlayerManager.movementAllowed = false;
            PlayerManager.lookingAroundAllowed = false;
            PlayerManager.shootingAllowed = false;
            PlayerManager.reloadingAllowed = false;
            PlayerManager.switchingWeaponsAllowed = false;
        }
        else if (Input.GetKeyDown(KeyCode.Escape))
        {
            Instance.inputField.DeactivateInputField();
            CommandHistoryIndex = commandHistory.Count - 1;
        }
        else if (inputFieldActive && commandHistory.Count > 0)
        {
            //cycling through command history

            if (Input.GetKeyDown(KeyCode.UpArrow))
            {
                inputField.text = commandHistory[CommandHistoryIndex];
                CommandHistoryIndex--;
            }
            else if (Input.GetKeyDown(KeyCode.DownArrow))
            {
                CommandHistoryIndex++;
                inputField.text = commandHistory[CommandHistoryIndex];
            }
        }
    }

    public static void ProcessMessage(string message)
    {
        message = message.Trim();

        if (message.Length > 0)
        {
            Instance.inputField.text = ""; //clearing the text box

            if (message[0] == '/')
            {
                //this message was indeed a command since '/' was the first character
                string[] splitCommand = message.Substring(1).Split(' ');

                if (splitCommand.Length == 1)
                {
                    if (splitCommand[0] == "help")
                    {
                        IEnumerable helpTxt = File.ReadLines(Directory.GetCurrentDirectory() + "/Assets/CommandsList.txt");

                        foreach (string command in helpTxt)
                        {
                            if (!string.IsNullOrWhiteSpace(command))
                            {
                                print(command);
                            }
                        }
                    }
                }
                else if (splitCommand.Length == 2)
                {
                    if (splitCommand[0] == "kill")
                    {
                        switch (splitCommand[1])
                        {
                            case "enemies":
                                foreach (Transform enemy in GameManager.Instance.enemiesHolder.transform)
                                {
                                    enemy.GetComponent<EnemyManager>().Die();
                                }

                                break;
                        }
                    }
                }
                else if (splitCommand.Length == 3)
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
                                string value = splitCommand[2].ToUpper();

                                switch (value)
                                {
                                    case string s when nameof(Gun.GunType.AK47).ToUpper() == value:
                                        GameManager.Instance.SpawnGun(Gun.GunType.AK47);
                                        break;
                                    case string s when nameof(Gun.GunType.M4A1).ToUpper() == value:
                                        GameManager.Instance.SpawnGun(Gun.GunType.M4A1);
                                        break;
                                    case string s when nameof(Gun.GunType.Shotgun).ToUpper() == value:
                                        GameManager.Instance.SpawnGun(Gun.GunType.Shotgun);
                                        break;
                                    case string s when nameof(Gun.GunType.Pistol).ToUpper() == value:
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
        inputFieldActive = false;

        //add the command to the commandHistory
        commandHistory.Add(message);
        CommandHistoryIndex++;
    }
}
