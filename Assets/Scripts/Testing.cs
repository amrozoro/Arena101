using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Testing : MonoBehaviour
{
    void Start()
    {
        
    }

    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Keypad1) || Input.GetKeyDown(KeyCode.Keypad2) || Input.GetKeyDown(KeyCode.Keypad3))
        {
            var powerups = GameManager.Instance.powerups;
            GameObject obj;

            if (Input.GetKeyDown(KeyCode.Keypad1))
            {
                obj = Instantiate(powerups[0], GameObject.Find("EnemyDrops").transform);
            }
            else if (Input.GetKeyDown(KeyCode.Keypad2))
            {
                obj = Instantiate(powerups[1], GameObject.Find("EnemyDrops").transform);
            }
            else
            {
                obj = Instantiate(powerups[2], GameObject.Find("EnemyDrops").transform);
            }

            obj.transform.position = Vector3.up * 3;
        }
        else if (Input.GetKeyDown(KeyCode.Keypad4))
        {
            PlayerManager.GiveMoney(1000);
        }
    }
}
