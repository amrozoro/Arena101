using System.Collections;
using UnityEngine;

public class RotateOnSpot : MonoBehaviour
{

    [SerializeField] private int lifetime = 15;

    public void Start()
    {
        Destroy(gameObject, lifetime);
    }

    void Update()
    {
        transform.Rotate((gameObject.CompareTag("AmmoBox") ? Vector3.up : Vector3.forward) * 180 * Time.deltaTime);
    }

    //IEnumerator DestroyAfterSeconds(int seconds)
    //{
    //    yield return new WaitForSeconds(seconds);
    //    Destroy(gameObject);
    //}
}
