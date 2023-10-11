import asyncio

async def receive():
    print('Hello ...')
    await asyncio.sleep(1)
    print('... World!')

async def send():
    
    while True:
        print('send')
        await asyncio.sleep(10)

async def main():
    task = asyncio.create_task (send())
    task2 = asyncio.create_task (receive())
    await task

asyncio.run(main())