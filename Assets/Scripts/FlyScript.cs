using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlyScript : MonoBehaviour
{
    public static FlyScript Instance;

    private static bool _flyToggle;
    public static bool flyToggle
    {
        get { return _flyToggle; }
        private set
        {
            _flyToggle = value;
            PlayerManager.Instance.rigidbodyComponent.useGravity = !value;
            PlayerManager.Instance.constantForceComponent.enabled = !value;
            PlayerManager.jumpingAllowed = !value;

            if (!value) PlayerManager.Instance.EnableGravityInAir();
        }
    }

    public static KeyCode flyKey
    {
        get;
        private set;
    } = KeyCode.F;

    public static KeyCode ascendKey
    {
        get;
        private set;
    } = PlayerManager.jumpKey;

    public static KeyCode descendKey
    {
        get;
        private set;
    } = KeyCode.LeftControl;

    public float ascendSpeed = 30f;
    public float descendSpeed = 30f;

    void Start()
    {
        Instance = this;
        flyToggle = false;
    }

    void Update()
    {
        if (Input.GetKeyDown(flyKey))
        {
            flyToggle = !flyToggle;
        }

        if (flyToggle)
        {
            if (Input.GetKey(ascendKey))
            {
                Vector3 direction = Vector3.up;
                Vector3 velocity = direction * ascendSpeed;

                transform.Translate(velocity * Time.deltaTime);
            }
            else if (Input.GetKey(descendKey))
            {
                Vector3 direction = Vector3.down;
                Vector3 velocity = direction * descendSpeed;

                transform.Translate(velocity * Time.deltaTime);
            }
        }
    }
}
